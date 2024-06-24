import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../registration/biografi/kelas_model.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  RxString userName = ''.obs;
  var selectedKelas = KelasModel(idKelas: 0, nama: '').obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4), () {
      isLoading.value = false;
    });
    loadUserName();
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('nama') ?? '';
  }

  Future<void> saveUserName(String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', nama);
    userName.value = nama;
  }

  Future<void> refreshHome() async {
    isLoading.value = true;
    await loadUserName();
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }
}
