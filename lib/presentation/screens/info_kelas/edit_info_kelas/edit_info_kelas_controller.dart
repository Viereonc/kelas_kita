import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../info_kelas_controller.dart';

class EditInfoKelasController extends GetxController {

  final TextEditingController descriptionController = TextEditingController();
  final InfoKelasController infoKelasController = Get.find();
  final Rx<File?> selectedImagePath = Rx<File?>(null);

  void initializeValues(String description, String imagePath) {
    if (imagePath.isNotEmpty) {
      selectedImagePath.value = File(imagePath);
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

  void saveInfo(int index, BuildContext context) {
    if (descriptionController.text.isNotEmpty) {
      infoKelasController.editInfoKelas(index, selectedImagePath.value, descriptionController.text);
      Navigator.pop(context);
    } else {
      // Handle empty description case
      // You can show a snackbar or a dialog to inform the user
    }
  }
}
