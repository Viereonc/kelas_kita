import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kelas_kita/routes/app_routes.dart';

import '../../../constants.dart';
import 'kelas_model.dart';

class BiografiController extends GetxController {
  var selectedImagePath = Rx<File?>(null);
  RxList<KelasModel> kelasList = <KelasModel>[].obs;
  var selectedKelas = KelasModel(
      idKelas: 0,
      nama: '',
      idBiodata: 0,
      jumlahKas: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
  ).obs;
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

  Future<void> convertToJpg(File image) async {
    final imageBytes = image.readAsBytesSync();
    final decodedImage = img.decodeImage(imageBytes);

    if (decodedImage != null) {
      final jpgImage = img.encodeJpg(decodedImage);
      final jpgFile = File(image.path.replaceAll(RegExp(r'\.\w+$'), '.jpg'));
      jpgFile.writeAsBytesSync(jpgImage);
      selectedImagePath.value = jpgFile;
    }
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
        List<KelasModel> fetchedKelas = jsonResponse.map((data) => KelasModel.fromJson(data)).toList();

        // Update the RxList using the `.value` property
        kelasList.value = fetchedKelas;

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

  Future<void> submitBiografi(String nama, String kelas, String nis, String alamat, String idUser, String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? idUser = prefs.getInt('id_user');

    if (idUser != null) {
      var uri = Uri.parse(baseUrl + biodataEndpoint);
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields.addAll(<String, String>{
        'id_user': idUser.toString(),
        'id_role': '7',
        'alamat': alamat,
        'nama': nama,
        'id_kelas': idKelas.value,
        'nis': nis,
        'status': pending,
      });

      if (imagePath.isNotEmpty) {
        // Check the file extension
        String extension = imagePath.split('.').last.toLowerCase();
        if (extension != 'jpg' && extension != 'jpeg') {
          Get.snackbar(
            'Error',
            'Format harus JPG',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          // Optionally convert to JPG
          await convertToJpg(File(imagePath));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: MediaType('image', 'jpg'),
          ));
        }
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Success: ${response.statusCode}');

        var responseData = await http.Response.fromStream(response);
        var decodedData = json.decode(responseData.body);
        String biografiStatus = decodedData['status'];
        String biografiIdKelas = decodedData['id_kelas'];

        await prefs.setString('status', biografiStatus);
        await prefs.setString('id_kelas', biografiIdKelas);

        if (biografiStatus == 'A') {
          Get.offNamed(Path.HOME_PAGE);
        } else if (biografiStatus == 'P') {
          Get.offNamed(Path.PENDING_PAGE);
        } else if (biografiStatus == 'D') {
          Get.offNamed(Path.BIOGRAFI_PAGE);
        }
      } else {
        var responseData = await http.Response.fromStream(response);
        print('Response status: ${response.statusCode}');
        print('Response body: ${responseData.body}');
        var decodedData = json.decode(responseData.body);

        if (decodedData['nis'] != null && decodedData['nis'].contains('The nis has already been taken.')) {
          Get.snackbar(
            'Error',
            'NIS sudah digunakan. silahkan gunakan NIS lain',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

        print('Error: ${response.statusCode}');
        print('Response body: ${decodedData}');
        print('Nama: $nama');
        print('NIS: $nis');
        print('Alamat: $alamat');
        print('User ID: $idUser');
        print('Image Path: $imagePath');
      }
    } else {
      print('User ID is null. Unable to submit biografi.');
    }
  }
}
