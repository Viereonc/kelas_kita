import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/constants.dart';
import 'package:kelas_kita/data/models/program_kas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProgramKelasController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController targetPengeluaranController =TextEditingController();
  final TextEditingController jadwalController = TextEditingController();
  final TextEditingController ketentuanController = TextEditingController();
  var isLoading = true.obs;
  RxList<ProgramKelasModel> programKelasList = <ProgramKelasModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProgramKasKelas();
  }

  void fetchProgramKasKelas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? idKelas = prefs.getInt('id_kelas');

      if (idKelas != null) {
        final response = await http.get(
          Uri.parse(baseUrl + programKasKelasEndPoint + '$idKelas'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var fetchedData = programKelasModelFromJson(response.body);
          programKelasList.value = fetchedData;
          print('Data fetched successfully: ${programKelasList.length} items');
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } else {
        print('id_kelas is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void initializeValues(String nama, String targetPengeluaran, String jadwal, String ketentuan) {
    namaController.text = nama;
    targetPengeluaranController.text = targetPengeluaran;
    jadwalController.text = jadwal;
    ketentuanController.text = ketentuan;
  }

  Future<void> editProgramKelas(
      int idProgram,
      String nama,
      String targetPengeluaran,
      String jadwal,
      String ketentuan,
      String token) async {
    final DateTime currentTime = DateTime.now();
    var url = Uri.parse('${baseUrl}api/program_kas/${idProgram}');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['id_program'] = idProgram.toString()
      ..fields['nama'] = nama
      ..fields['jumlah'] = targetPengeluaran
      ..fields['jadwal'] = jadwal
      ..fields['ketentuan'] = ketentuan
      ..fields['updated_at'] = currentTime.toIso8601String();

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Program kelas berhasil diedit: ${response.statusCode}');
      } else {
        print('Gagal mengedit program kelas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
