import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/data/models/info_tugas.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/option_edit_delete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class InfoTugasController extends GetxController {
  RxList<InfoTugasModel> infoTugasList = <InfoTugasModel>[].obs;
  var isLoading = true.obs;
  var userStatus = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUserStatus();
    fetchInformasiTugas();
  }

  void setUserStatus() {
    userStatus.value = 'siswa';
  }

  void openIconButtonpressed(BuildContext context, int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    print(index);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteInfoTugas(index: index, namaTugas: namaTugas, guruPemberiTugas: guruPemberiTugas, deadlineTugas: deadlineTugas, ketentuanTugas: ketentuanTugas),
    );
  }

  void fetchInformasiTugas() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(baseUrl + infoGetTugasEndPoint),
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

  Future<void> addAndPostInfoTugas(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String idKelas, Kelas kelas, String token) async {
    final DateTime currentTime = DateTime.now();

    int parsedIdKelas = int.parse(idKelas);

    DateTime parsedDeadline = DateTime.parse(deadlineTugas);

    InfoTugasModel infoTugas = InfoTugasModel(
        idTugas: infoTugasList.length + 1,
        idKelas: parsedIdKelas,
        nama: namaTugas,
        guru: guruPemberiTugas,
        deadline: parsedDeadline,
        ketentuan: ketentuanTugas,
        createdAt: currentTime,
        updatedAt: currentTime,
        kelas: kelas
    );

    infoTugasList.add(infoTugas);

    saveInfoTugas();

    await postInfoTugas(idKelas, namaTugas, guruPemberiTugas, deadlineTugas, ketentuanTugas, token);
  }

  void editInfoTugas(int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String idKelas, Kelas kelas, String token) {
    final DateTime currentTime = DateTime.now();

    InfoTugasModel updatedInfoTugas = InfoTugasModel(
        idTugas: infoTugasList[index].idTugas,
        idKelas: infoTugasList[index].idKelas,
        nama: infoTugasList[index].nama,
        guru: infoTugasList[index].guru,
        deadline: infoTugasList[index].deadline,
        ketentuan: infoTugasList[index].ketentuan,
        createdAt: infoTugasList[index].createdAt,
        updatedAt: currentTime,
        kelas: kelas
    );

    infoTugasList[index] = updatedInfoTugas;

    saveInfoTugas();
  }

  void deleteInfoTugas(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url = Uri.parse('${baseUrl}api/tugas/${index}');
      final headers = {
        'Authorization': 'Bearer $token',
      };
      await http.delete(url, headers: headers);
      fetchInformasiTugas();
    } else {
      print('Token not found');
    }
  }

  Future<void> postInfoTugas(String idKelas, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, String token) async {
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

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Info tugas berhasil diunggah');
      } else {
        print('Gagal mengunggah info tugas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void saveInfoTugas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(infoTugasList);
    prefs.setString('InfoTugas_list', jsonString);
  }
}