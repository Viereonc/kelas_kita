import 'package:get/get.dart';

class DetailProfileController extends GetxController {
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
}