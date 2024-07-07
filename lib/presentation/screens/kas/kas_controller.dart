import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/metode_pembayaran.dart';

class KasController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  final Map<String, List<String>> paymentHistory = {
    'Maret 2024': ['Gopay • 14 Maret 2024 08.45 AM', 'Gopay • 14 Maret 2024 08.45 AM', 'Gopay • 14 Maret 2024 08.45 AM', 'Gopay • 14 Maret 2024 08.45 AM',],
    'April 2024': ['Gopay • 14 Maret 2024 08.45 AM', 'Gopay • 14 Maret 2024 08.45 AM'],
  };

  void openIconButtonpressed (BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => MetodePembayaran());
  }
}
