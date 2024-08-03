import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../constants.dart';
import '../../../../data/models/biografi_model.dart';

class EditProfileController extends GetxController {
  var isLoading = true.obs;

  var ctrUsername = TextEditingController();
  var ctrPhone = TextEditingController();
  var ctrAddress = TextEditingController();
  var ctrBio = TextEditingController();
  var selectedImagePath = Rx<File?>(null);
  final RxString imageUrl = ''.obs;


  @override
  void onInit() {
    super.onInit();
    loadLoading();
    fetchBiografi();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');
      int? idBiodata = prefs.getInt('id_biodata');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$biodataEndpointGet$userId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          ctrUsername.text = data['nama'] ?? '';
          ctrPhone.text = data['nomor'] ?? '';
          ctrAddress.text = data['alamat'] ?? '';
          ctrBio.text = data['bio'] ?? '';
          imageUrl.value = data['image'];

          if (data['id_biodata'] != null) {
            prefs.setInt('id_biodata', data['id_biodata']);
          }

          print('Successfully loaded biografi data');
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          throw Exception('Failed to load biografi');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> editProfile(String nama, String alamat, String bio, File? imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? idBiodata = prefs.getInt('id_biodata');
    int? idUser = prefs.getInt('id_user');

    if (idUser != null && token != null) {
      var uri = Uri.parse('${baseUrl}api/biodata/$idBiodata');
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(<String, String>{
        'Authorization': 'Bearer $token',
      });

      request.fields.addAll(<String, String>{
        'id_biodata': idBiodata.toString(),
        'nama': nama,
        'alamat': alamat,
        'bio': bio,
      });

      if (imageFile != null && imageFile.path.isNotEmpty) {
        final mimeTypeData = lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');
        if (mimeTypeData != null && mimeTypeData.length == 2) {
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
          ));
        }
      }

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          try {
            var decodedData = json.decode(responseData.body);
            print('Success: ${response.statusCode}');
            print('Response body: ${decodedData}');
          } catch (e) {
            print('Error decoding JSON: $e');
            print('Response body: ${responseData.body}');
          }
        } else {
          var responseData = await http.Response.fromStream(response);
          print('Error: ${response.statusCode}');
          print('Response body: ${responseData.body}');
        }
      } catch (e) {
        print('Error during request: $e');
      }
    } else {
      print('User ID or token is null. Unable to submit profile edit.');
    }
  }
}
