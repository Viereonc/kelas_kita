  import 'dart:io';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:kelas_kita/constants.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'dart:convert';
  import 'info_kelas_model.dart';
  import 'option_edit_delete.dart';
  import 'package:http/http.dart' as http;

  class InfoKelasController extends GetxController {
    RxList<InfoKelasModel> infoKelasList = <InfoKelasModel>[].obs;
    var isLoading = true.obs;
    var selectedImagePath = Rx<File?>(null);
    var userStatus = ''.obs;

    @override
    void onInit() {
      super.onInit();
      setUserStatus();
      fetchInformasiKelas();
    }

    void setUserStatus() {
      userStatus.value = 'siswa';
    }

    void fetchInformasiKelas() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        final response = await http.get(
          Uri.parse(baseUrl + infoGetKelasEndpoint),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          infoKelasList.value = infoKelasModelFromJson(response.body);
          isLoading.value = false;
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    void openIconButtonpressed(BuildContext context, int index, String description, String imagePath) {
      print(index);
      showModalBottomSheet(
        context: context,
        builder: (ctx) => OptionEditDeleteInfoKelas(index: index, description: description, imagePath: imagePath),
      );
    }

    Future<void> addAndPostInfoKelas(File? imageFile, String description, String idKelas, String token) async {
      final DateTime currentTime = DateTime.now();

      int parsedIdKelas = int.parse(idKelas);

      InfoKelasModel infoKelas = InfoKelasModel(
        idInformasiKelas: infoKelasList.length + 1,
        idKelas: parsedIdKelas,
        image: imageFile?.path ?? "",
        pengumuman: description,
        createdAt: currentTime,
        updatedAt: currentTime,
      );

      infoKelasList.add(infoKelas);

      saveInfoKelas();

      await postInfoKelas(parsedIdKelas.toString(), imageFile?.path ?? "", description, token);
    }

    void editInfoKelas(int index, File? imageFile, String description) {
      final DateTime currentTime = DateTime.now();

      InfoKelasModel updatedInfoKelas = InfoKelasModel(
        idInformasiKelas: infoKelasList[index].idInformasiKelas,
        idKelas: infoKelasList[index].idKelas,
        image: imageFile?.path ?? infoKelasList[index].image,
        pengumuman: description,
        createdAt: infoKelasList[index].createdAt,
        updatedAt: currentTime,
      );

      infoKelasList[index] = updatedInfoKelas;

      saveInfoKelas();
    }

    void deleteInfoKelas(int index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        final url = Uri.parse('${baseUrl}api/informasi_kelas/${index}');
        final headers = {
          'Authorization': 'Bearer $token',
        };

        await http.delete(url, headers: headers);
        fetchInformasiKelas();
      } else {
        print('Token not found');
      }
    }


    void saveInfoKelas() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(infoKelasList);
      prefs.setString('InfoKelas_list', jsonString);
    }

    Future<void> postInfoKelas(String idKelas, String imagePath, String description, String token) async {
      var url = Uri.parse(baseUrl + infoKelasEndpoint);
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['id_kelas'] = idKelas
        ..fields['pengumuman'] = description;

      if (imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      }

      try {
        var response = await request.send();
        if (response.statusCode == 201) {
          print('Info kelas berhasil diunggah');
        } else {
          print('Gagal mengunggah info kelas: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
