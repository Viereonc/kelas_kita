import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/metode_pembayaran.dart';

class KasController extends GetxController {

  final Map<String, List<String>> paymentHistory = {
    'Januari': ['Pembayaran ke-1', 'Pembayaran ke-2', 'Pembayaran ke-3', 'Pembayaran ke-4',],
    'Februari': ['Pembayaran ke-1', 'Pembayaran ke-2'],
  };

  void openIconButtonpressed (BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => MetodePembayaran());
  }
}
