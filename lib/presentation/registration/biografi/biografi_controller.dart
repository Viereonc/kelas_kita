import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../../constants.dart';
import 'kelas_model.dart';

class BiografiController extends GetxController {
  var selectedImagePath = Rx<File?>(null);
  List<KelasModel> kelasList = <KelasModel>[];
  var selectedKelas = KelasModel(idKelas: 0, nama: '').obs;
  var idKelas = ''.obs;
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void onInit() {
    fetchKelas();
    super.onInit();
  }

  Future<void> fetchKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(baseUrl + kelasEndpoint),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        kelasList = jsonResponse.map((data) => KelasModel.fromJson(data)).toList();
        print('Successfully loaded kelas');

        for (var kelas in kelasList) {
          print(kelas.nama);
        }
      } else {
        print('Failed to load kelas, status code: ${response.statusCode}');
        throw Exception('Failed to load kelas');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> submitBiografi(String nama, String kelas, String nis, String alamat, String userId, String imagePath) async {

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
        'id_role': '1',
        'alamat': alamat,
        'nama': nama,
        'id_kelas': kelas,
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
        Get.toNamed(Path.PENDING_PAGE);
      } else {
        print('Error: ${response.statusCode}');
        print(nama);
        print(nis);
        print(alamat);
        print(userId);
        print(imagePath);
      }
    } else {
      print('User ID is null. Unable to submit biografi.');
    }
  }
}