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
    userStatus.value = 'sekretaris';
  }

  void openIconButtonpressed(BuildContext context, int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas, int idTugas) {
    print(index);
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteInfoTugas(index: index, namaTugas: namaTugas, guruPemberiTugas: guruPemberiTugas, deadlineTugas: deadlineTugas, ketentuanTugas: ketentuanTugas, idTugas: idTugas,),
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
      kelas: kelas,
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

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Info tugas berhasil diunggah');
        fetchInformasiTugas();
      } else {
        print('Gagal mengunggah info tugas: ${response.statusCode}');
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
}