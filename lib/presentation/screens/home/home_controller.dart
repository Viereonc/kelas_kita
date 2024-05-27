import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4), () {
      isLoading.value = false;
    });
  }
}
