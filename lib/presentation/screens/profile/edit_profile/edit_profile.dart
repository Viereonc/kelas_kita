import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'edit_profile_controller.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../../../widgets/TextFormField.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  EditProfileController editProfileController = Get.put(EditProfileController());

  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrPhone = TextEditingController();
  TextEditingController ctrAddress = TextEditingController();
  TextEditingController ctrBio = TextEditingController();

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      editProfileController.selectedImagePath.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppBar(
            surfaceTintColor: Colors.white,
            title: Text(
              "Edit Profile",
              style: tsHeader2(),
            ),
            centerTitle: true,
            leading: Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Obx(() => Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: screenWidth * 0.43,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: editProfileController.selectedImagePath.value != null
                                  ? FileImage(editProfileController.selectedImagePath.value!)
                                  : NetworkImage("https://picsum.photos/500/300") as ImageProvider,
                              fit: BoxFit.cover)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: -screenWidth * 0.05,
                            left: (screenWidth * 0.43 - screenWidth * 0.1) / 2,
                            child: Container(
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: Container(
                                  width: screenWidth * 0.085,
                                  height: screenWidth * 0.085,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: primeryColorMedium),
                                  child: GestureDetector(
                                      onTap: _getImageFromGallery,
                                      child: Icon(Icons.edit,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                height: screenHeight * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email',
                        style: tsSubHeader4(fontWeight: FontWeight.w700)),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: textFormField(
                          label: "Email",
                          controller: ctrEmail,
                          labelStyle: tsParagraft3(
                              color: Colors.black.withOpacity(0.3)),
                          height: screenHeight * 0.06),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.12,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Telephone',
                        style: tsSubHeader4(fontWeight: FontWeight.w700)),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: textFormField(
                          label: "Nomor Telephone",
                          controller: ctrPhone,
                          labelStyle: tsParagraft3(
                              color: Colors.black.withOpacity(0.3)),
                          height: screenHeight * 0.06),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alamat',
                        style: tsSubHeader4(fontWeight: FontWeight.w700)),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: textFormField(
                          label: "Alamat",
                          controller: ctrAddress,
                          labelStyle: tsParagraft3(
                              color: Colors.black.withOpacity(0.3)),
                          height: screenHeight * 0.06),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: screenHeight * 0.14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bio',
                        style: tsSubHeader4(fontWeight: FontWeight.w700)),
                    Container(
                      child: textFormField(
                          label: "Bio",
                          controller: ctrBio,
                          labelStyle: tsParagraft3(
                              color: Colors.black.withOpacity(0.3)),
                          height: screenHeight * 0.1),
                    ),
                  ],
                ),
              ),
              Button(
                  label: "Simpan Perubahan",
                  textStyle: tsSubHeader4(),
                  textColor: Colors.white,
                  backgroundColor: primeryColorMedium,
                  side: BorderSide.none,
                  onPressed: () {
                    editProfileController.ctrEdit(
                      ctrEmail.text,
                      ctrPhone.text,
                      ctrAddress.text,
                      ctrBio.text,
                      editProfileController.selectedImagePath.value,
                    );
                    Get.to(() => ProfileScreen())?.then((value) {
                      ctrEmail.clear();
                      ctrPhone.clear();
                      ctrAddress.clear();
                      ctrBio.clear();
                      editProfileController.selectedImagePath.value = null;
                    });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
