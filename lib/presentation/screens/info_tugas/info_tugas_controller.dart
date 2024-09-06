import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/data/models/info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/option_edit_delete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';

class InfoTugasController extends GetxController {
  RxList<InfoTugasModel> infoTugasList = <InfoTugasModel>[].obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;
  var isLoading = true.obs;
  var userStatus = ''.obs;
  RxString currentIdKelas = ''.obs;
  var selectedFilePath = Rx<File?>(null);
  var fileUrl = Rx<String>('');

  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deadlineTugasController = TextEditingController();
  final TextEditingController ketentuanTugasController = TextEditingController();
  final ValueNotifier<String?> selectedGuru = ValueNotifier<String?>(null);
  final List<String> guruList = ["Pak Aji", "Pak Dwi", "Pak Fahmi", "Pak Agus"];

  @override
  void onInit() {
    super.onInit();
    fetchInformasiTugas();
    fetchBiografi();
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
          var fetchedData = InfoBiografiModel.fromJson(jsonResponse);
          biografiList.value = [fetchedData];
          userStatus.value = fetchedData.role.nama.toString();
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchInformasiTugas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      final response = await http.get(
        Uri.parse('$baseUrl$infoGetTugasEndPoint$idKelas'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        infoTugasList.value = infoTugasModelFromJson(response.body);
        isLoading.value = false;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void initializeValues(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String file) {
    namaTugasController.text = namaTugas;
    selectedGuru.value = guruPemberiTugas;
    deadlineTugasController.text = deadlineTugas;
    ketentuanTugasController.text = ketentuanTugas;
    fileUrl.value = file;
  }

  Future<void> addAndPostInfoTugas(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, File? file, String idKelas, String token,) async {
    final DateTime currentTime = DateTime.now();
    int parsedIdKelas = int.parse(idKelas);

    DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    DateTime parsedDeadline = DateTime.parse(deadlineTugas);

    InfoTugasModel infoTugas = InfoTugasModel(
      idTugas: infoTugasList.length + 1,
      idKelas: parsedIdKelas,
      nama: namaTugas,
      guru: guruPemberiTugas,
      deadline: parsedDeadline,
      ketentuan: ketentuanTugas,
      file: file.toString(),
      createdAt: currentTime,
      updatedAt: currentTime,
    );

    infoTugasList.add(infoTugas);

    var url = Uri.parse(baseUrl + infoTugasEndPoint);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['id_kelas'] = idKelas
      ..fields['nama'] = namaTugas
      ..fields['guru'] = guruPemberiTugas
      ..fields['deadline'] = deadlineTugas
      ..fields['ketentuan'] = ketentuanTugas;

    if (file != null) {
      var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
      var fileLength = await file.length();

      request.files.add(http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: file.path.split('/').last,
      ));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Info tugas berhasil diunggah');
        fetchInformasiTugas();
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Gagal mengunggah info tugas: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
    );

    if (result != null) {
      selectedFilePath.value = File(result.files.single.path!);
    } else {
      Get.snackbar(
        'Error',
        'Tidak ada file yang dipilih',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> editInfoTugas(int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, File? file, String idKelas, String token, int idTugas) async {
    final DateTime currentTime = DateTime.now();

    int parsedIdKelas = int.parse(idKelas);

    DateTime parsedDeadline = DateTime.parse(deadlineTugas);

    String filePath = file?.path ?? fileUrl.value;

    InfoTugasModel updatedInfoTugas = InfoTugasModel(
      idTugas: idTugas,
      idKelas: parsedIdKelas,
      nama: namaTugas,
      guru: guruPemberiTugas,
      deadline: parsedDeadline,
      ketentuan: ketentuanTugas,
      file: file != null ? base64Encode(file.readAsBytesSync()) : null,
      createdAt: currentTime,
      updatedAt: currentTime,
    );

    var url = Uri.parse('${baseUrl}api/tugas/${idTugas}');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['id_tugas'] = updatedInfoTugas.idTugas.toString()
      ..fields['id_kelas'] = idKelas
      ..fields['nama'] = namaTugas
      ..fields['guru'] = guruPemberiTugas
      ..fields['deadline'] = deadlineTugas
      ..fields['ketentuan'] = ketentuanTugas;

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }

    try {
      var response = await request.send();
      fetchInformasiTugas();
      if (response.statusCode == 200) {
        print('Info kelas berhasil diedit: ${response.statusCode}');
        fetchInformasiTugas();
        infoTugasList[index] = updatedInfoTugas;
        infoTugasList.refresh();
      } else {
        print('Gagal mengedit info kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteInfoTugas(int idTugas) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        final url = Uri.parse('${baseUrl}api/tugas/$idTugas');
        final headers = {
          'Authorization': 'Bearer $token',
        };

        await http.delete(url, headers: headers);
        fetchInformasiTugas();
      } else {
        print('Token not found');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Open Bottom Sheet
  void openIconButtonpressed(BuildContext context, int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String file, int idTugas) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteInfoTugas(
        index: index,
        namaTugas: namaTugas,
        guruPemberiTugas: guruPemberiTugas,
        deadlineTugas: deadlineTugas,
        ketentuanTugas: ketentuanTugas,
        file: file,
        idTugas: idTugas,
      ),
    );
  }
}
