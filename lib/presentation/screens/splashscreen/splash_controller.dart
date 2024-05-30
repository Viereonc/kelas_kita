import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kelas_kita/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Default ke false jika null
    print('isLoggedIn: $isLoggedIn'); // Tambahkan ini untuk debugging
    if (isLoggedIn == true) {
      Get.offNamed(Path.HOME_PAGE);
    } else {
      Get.offNamed(Path.ONBOARDING_PAGE);
    }
  }
}