import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../info_kelas_model.dart';
import 'package:http/http.dart' as http;

class EditInfoKelasController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  final Rx<File?> selectedImagePath = Rx<File?>(null);
  final RxString imageUrl = ''.obs;
  RxList<InfoKelasModel> infoKelasList = <InfoKelasModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInformasiKelas();
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
        print('Data fetched successfully: ${infoKelasList.length} items');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void initializeValues(String description, String imagePath, int index, int idInformasiKelas) {
    print(idInformasiKelas);
    print(description);
    print(imagePath);
    if (imagePath.isNotEmpty) {
      imageUrl.value = imagePath; // Store the initial image URL
    }
    descriptionController.text = description;
  }

  Future<void> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = File(pickedFile.path);
    }
  }

  Future<void> editInfoKelas(int index, File? imageFile, String description, String idKelas, String token, int idInformasiKelas) async {
    final DateTime currentTime = DateTime.now();

    String imagePath = imageFile?.path ?? imageUrl.value; // Use the initial URL if no new image is selected

    InfoKelasModel updatedInfoKelas = InfoKelasModel(
      idInformasiKelas: idInformasiKelas,
      idKelas: int.parse(idKelas),
      image: imagePath,
      pengumuman: description,
      createdAt: currentTime,
      updatedAt: currentTime,
    );

    var url = Uri.parse('${baseUrl}api/informasi_kelas/${idInformasiKelas}');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['id_informasi_kelas'] = updatedInfoKelas.idInformasiKelas.toString()
      ..fields['id_kelas'] = idKelas
      ..fields['pengumuman'] = description;

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', updatedInfoKelas.image));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Info kelas berhasil diedit');
        fetchInformasiKelas();
      } else {
        print('Gagal mengedit info kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
