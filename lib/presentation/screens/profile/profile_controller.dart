import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var userName = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoading();
    loadUserName();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
}
