import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/biografi_model.dart';
import 'info_kelas_model.dart';
import 'option_edit_delete.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class InfoKelasController extends GetxController {
  RxList<InfoKelasModel> infoKelasList = <InfoKelasModel>[].obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  var isLoading = true.obs;
  var selectedImagePath = Rx<File?>(null);
  var imageUrl = ''.obs;
  var userStatus = ''.obs;
  var isRefresh = false.obs;
  final TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchInformasiKelas();
    fetchBiografi();
  }

  Future<void> refresh() async {
    isRefresh(true);
    await fetchInformasiKelas();
    isRefresh(false);
  }

  Future<void> fetchInformasiKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      final response = await http.get(
        Uri.parse('$baseUrl$infoGetKelasEndpoint$idKelas'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 500) {
        final List<dynamic> data = jsonDecode(response.body);
        infoKelasList.value = data.map((item) => InfoKelasModel.fromJson(item)).toList();
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

  void openIconButtonpressed(BuildContext context, int index, String description, String imagePath, int idInformasiKelas) {
    print('List length: ${infoKelasList.length}');
    print('ID being accessed: $idInformasiKelas');
    print(description);
    print(imagePath);
    if (infoKelasList.any((element) => element.idInformasiKelas == idInformasiKelas)) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => OptionEditDeleteInfoKelas(index: index, description: description, imagePath: imagePath, idInformasiKelas: idInformasiKelas,),
      );
    } else {
      print('ID di luar batas');
    }
  }

  Future<void> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = File(pickedFile.path);
    }
  }

  Future<void> addAndPostInfoKelas(File? imageFile, String description, String idKelas, String token) async {
    final DateTime currentTime = DateTime.now();

    int parsedIdKelas = int.parse(idKelas);

    InfoKelasModel infoKelas = InfoKelasModel(
      idInformasiKelas: infoKelasList.length,
      idKelas: parsedIdKelas,
      image: imageFile?.path ?? "",
      pengumuman: description,
      createdAt: currentTime,
      updatedAt: currentTime,
    );

    infoKelasList.add(infoKelas);

    try {
      var url = Uri.parse(baseUrl + infoKelasEndpoint);
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['id_kelas'] = idKelas
        ..fields['pengumuman'] = description;

      if (imageFile?.path.isNotEmpty ?? false) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile!.path));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        print('Info kelas berhasil diunggah');
        fetchInformasiKelas();
      } else {
        print('Gagal mengunggah info kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteInfoKelas(int idInformasiKelas) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        final url = Uri.parse('${baseUrl}api/informasi_kelas/$idInformasiKelas');
        final headers = {
          'Authorization': 'Bearer $token',
        };

        await http.delete(url, headers: headers);
        fetchInformasiKelas();
      } else {
        print('Token not found');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editInfoKelas(int index, File? imageFile, String description, String idKelas, String token, int idInformasiKelas) async {
    final DateTime currentTime = DateTime.now();

    String imagePath = imageFile?.path ?? imageUrl.value;

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
      if (response.statusCode == 200 || response.statusCode == 500) {
        print('Info kelas berhasil diedit : ${response.statusCode}');
        await fetchInformasiKelas();
        infoKelasList.value[index] = updatedInfoKelas;
        infoKelasList.refresh();
        Get.snackbar('Pesan', 'Berhasil di edit');
        update();
      } else {
        print('Gagal mengedit info kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void initializeValues(String description, String imagePath, int index, int idInformasiKelas) {
    print(idInformasiKelas);
    print(description);
    print(imagePath);
    if (imagePath.isNotEmpty) {
      imageUrl.value = imagePath;
    }
    descriptionController.text = description;
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$biodataEndpointGet$userId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('JSON Response: $jsonResponse');

          var fetchedData = InfoBiografiModel.fromJson(jsonResponse);
          biografiList.value = [fetchedData];

          userStatus.value = fetchedData.role.nama.toString();

          print('Successfully loaded biografi data: ${biografiList.length}');
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
}
