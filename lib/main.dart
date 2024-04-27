import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends GetMaterialApp {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kelas Kita',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.ONBOARDING,
      getPages: AppPages.routes,
    );
  }
}