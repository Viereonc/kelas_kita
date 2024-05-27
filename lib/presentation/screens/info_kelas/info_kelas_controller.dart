import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'option_edit_delete.dart';

class InfoKelasController extends GetxController {
  var infoKelasList = [].obs;
  var isLoading = true.obs;
  var selectedImagePath = Rx<File?>(null);
  var userStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadInfoKelas();
    setUserStatus();
  }

  void setUserStatus() {
    userStatus.value = 'sekretaris';
  }

  void openIconButtonpressed(BuildContext context, int index, String description, String imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => OptionEditDeleteInfoKelas(index: index, description: description, imagePath: imagePath),
    );
  }

  void addInfoKelas(File? imageFile, String description) {
    final DateTime currentTime = DateTime.now();
    infoKelasList.add({
      "description": description,
      "image": imageFile?.path ?? "",
      "time": currentTime.toIso8601String(), // Menyimpan waktu saat ini dalam format ISO 8601
    });
    saveInfoKelas();
  }

  void editInfoKelas(int index, File? imageFile, String description) {
    final DateTime currentTime = DateTime.now();
    infoKelasList[index] = {
      "description": description,
      "image": imageFile?.path ?? "",
      "time": currentTime.toIso8601String(), // Menyimpan waktu saat ini dalam format ISO 8601
    };
    saveInfoKelas();
  }

  void deleteInfoKelas(int index) {
    infoKelasList.removeAt(index);
    saveInfoKelas();
  }

  void saveInfoKelas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(infoKelasList);
    prefs.setString('InfoKelas_list', jsonString);
  }

  void loadInfoKelas() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('InfoKelas_list');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      infoKelasList.value = jsonList.map((item) => item as Map<String, dynamic>).toList();
    }
    isLoading.value = false;
  }
}
