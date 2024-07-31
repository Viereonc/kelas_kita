import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarControllerGuru extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}