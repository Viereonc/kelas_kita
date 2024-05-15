import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var ctrEmail = RxString('initial');
  var ctrPhone = RxString('initial');
  var ctrAddress = RxString('initial');
  var ctrBio = RxString('initial');
  var selectedImagePath = Rx<File?>(null);

  ctrEdit(String email, String phoneNumber, String address, String bio, File? imageFile) {
    ctrEmail.value = email;
    ctrPhone.value = phoneNumber;
    ctrAddress.value = address;
    ctrBio.value = bio;
    selectedImagePath.value = imageFile;
  }
}
