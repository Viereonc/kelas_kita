import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../../constants.dart';

class BiografiController extends GetxController {
  var selectedImagePath = Rx<File?>(null);
  var selectedValue = '10 PPLG 1'.obs;
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  Future<void> submitBiografi(String nama, String kelas, String nis, String alamat, String imagePath) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('user_id');

    if (userId != null) {
      var uri = Uri.parse(baseUrl + biodataEndpoint);
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields.addAll(<String, String>{
        'user_id': userId.toString(),
        'alamat': alamat,
        'nama': nama,
        'kelas': kelas,
        'nis': nis,
        'status': 'A',
      });

      if (imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imagePath,
          contentType: MediaType('image', 'jpg'),
        ));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Success: ${response.statusCode}');
        Get.toNamed(Path.HOME_PAGE);
      } else {
        print('Error: ${response.statusCode}');
      }
    } else {
      print('User ID is null. Unable to submit biografi.');
    }
  }

}