import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/option_edit_delete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoTugasController extends GetxController {
  var infoTugasList = [].obs;
  var isLoading = true.obs;
  var userStatus = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUserStatus();
    loadInfoTugas();
  }

  void setUserStatus() {
    userStatus.value = 'sekretaris';
  }

  void openIconButtonpressed(BuildContext context, int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteInfoTugas(index: index, namaTugas: namaTugas, guruPemberiTugas: guruPemberiTugas, deadlineTugas: deadlineTugas, ketentuanTugas: ketentuanTugas),
    );
  }

  void addInfoTugas(String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    final DateTime currentTime = DateTime.now();
    infoTugasList.add({
      "namaTugas": namaTugas,
      "guruPemberiTugas": guruPemberiTugas,
      "deadlineTugas": deadlineTugas,
      "ketentuanTugas": ketentuanTugas,
      "time": currentTime.toIso8601String(),
    });
    saveInfoTugas();
  }

  void editInfoTugas(int index, String namaTugas, String guruPemberiTugas, String deadlineTugas, String ketentuanTugas) {
    final DateTime currentTime = DateTime.now();
    infoTugasList[index] = {
      "namaTugas": namaTugas,
      "guruPemberiTugas": guruPemberiTugas,
      "deadlineTugas": deadlineTugas,
      "ketentuanTugas": ketentuanTugas,
      "time": currentTime.toIso8601String(),
    };
    saveInfoTugas();
  }

  void deleteInfoTugas(int index) {
    infoTugasList.removeAt(index);
    saveInfoTugas();
  }

  void saveInfoTugas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(infoTugasList);
    prefs.setString('InfoTugas_list', jsonString);
  }

  void loadInfoTugas() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('InfoTugas_list');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      infoTugasList.value = jsonList.map((item) => item as Map<String, dynamic>).toList();
    }
    isLoading.value = false;
  }
}