import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgramKelasController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController targetPengeluaranController = TextEditingController();
  final TextEditingController jadwalController = TextEditingController();
  final TextEditingController ketentuanController = TextEditingController();

  @override
  void onClose() {
    namaController.dispose();
    targetPengeluaranController.dispose();
    jadwalController.dispose();
    ketentuanController.dispose();
    super.onClose();
  }
}
