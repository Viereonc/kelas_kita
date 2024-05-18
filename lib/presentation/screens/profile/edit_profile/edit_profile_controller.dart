import 'dart:io';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var isLoading = true.obs;

  var ctrEmail = RxString('');
  var ctrPhone = RxString('');
  var ctrAddress = RxString('');
  var ctrBio = RxString('');
  var selectedImagePath = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadLoading();
  }

  void loadLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  ctrEdit(String email, String phoneNumber, String address, String bio, File? imageFile) {
    ctrEmail.value = email;
    ctrPhone.value = phoneNumber;
    ctrAddress.value = address;
    ctrBio.value = bio;
    selectedImagePath.value = imageFile;
  }
}
