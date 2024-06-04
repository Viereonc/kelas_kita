import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var userName = 'User'.obs;

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
    userName.value = prefs.getString('nama') ?? 'User';
  }

  Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', name);
    userName.value = name;
  }

  Future<void> refreshHome() async {
    isLoading.value = true;
    await loadUserName();
    await Future.delayed(Duration(seconds: 2)); // Simulasi pemuatan data
    isLoading.value = false;
  }
}
