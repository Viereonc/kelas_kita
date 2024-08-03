import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/constants.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_controller.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';
import '../../../widgets/TextFormField.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final EditProfileController editProfileController = Get.put(EditProfileController());

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              "Edit Profile",
              style: tsHeader2(
                screenSize: screenWidth,
              ),
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
      body: Obx(() {
        if (editProfileController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Obx(() {
                      var selectedImagePath = editProfileController.selectedImagePath.value;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: screenWidth * 0.43,
                        height: screenWidth * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: screenWidth * 0.43,
                                height: screenWidth * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: selectedImagePath != null && File(selectedImagePath.path).existsSync()
                                        ? FileImage(selectedImagePath)
                                        : NetworkImage(baseUrl + storage + editProfileController.imageUrl.value) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
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
                                      color: primeryColorMedium,
                                    ),
                                    child: GestureDetector(
                                      onTap: _getImageFromGallery,
                                      child: Icon(Icons.edit, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.05),
                    height: screenHeight * 0.12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Username', style: tsSubHeader4(fontWeight: FontWeight.w700, screenSize: screenWidth,)),
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: textFormField(
                            label: "Username",
                            controller: editProfileController.ctrUsername,
                            labelStyle: tsParagraft3(
                              color: Colors.black.withOpacity(0.3),
                              screenSize: screenWidth,
                            ),
                            height: screenHeight * 0.06,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: screenHeight * 0.12,
                  //   margin: EdgeInsets.symmetric(vertical: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('Nomor Handphone', style: tsSubHeader4(fontWeight: FontWeight.w700, screenSize: screenWidth,)),
                  //       Container(
                  //         margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  //         child: textFormField(
                  //             label: "Nomor Handphone",
                  //             controller: editProfileController.ctrPhone,
                  //             textInputType: TextInputType.phone,
                  //             validator: (value) {
                  //               if (value == null || value.isEmpty) {
                  //                 return 'Nomor Telepon tidak boleh kosong';
                  //               }
                  //               if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  //                 return 'Masukkan nomor telepon yang valid';
                  //               }
                  //               return null;
                  //             },
                  //             labelStyle: tsParagraft3(
                  //               color: Colors.black.withOpacity(0.3),
                  //               screenSize: screenWidth,
                  //             ),
                  //             height: screenHeight * 0.06),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: screenHeight * 0.12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Alamat',
                            style: tsSubHeader4(fontWeight: FontWeight.w700, screenSize: screenWidth,)),
                        Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: textFormField(
                              label: "Alamat",
                              controller: editProfileController.ctrAddress,
                              labelStyle: tsParagraft3(
                                color: Colors.black.withOpacity(0.3),
                                screenSize: screenWidth,
                              ),
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
                            style: tsSubHeader4(fontWeight: FontWeight.w700, screenSize: screenWidth,)),
                        Container(
                          child: textFormField(
                              label: "Bio",
                              controller: editProfileController.ctrBio,
                              labelStyle: tsParagraft3(
                                color: Colors.black.withOpacity(0.3),
                                screenSize: screenWidth,
                              ),
                              height: screenHeight * 0.1),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    label: "Simpan Perubahan",
                    textStyle: tsSubHeader4(
                      screenSize: screenWidth,
                    ),
                    textColor: Colors.white,
                    backgroundColor: primeryColorMedium,
                    side: BorderSide.none,
                    onPressed:  () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? token = prefs.getString('token');

                      editProfileController.editProfile(
                        editProfileController.ctrUsername.text,
                        // editProfileController.ctrPhone.text,
                        editProfileController.ctrAddress.text,
                        editProfileController.ctrBio.text,
                        editProfileController.selectedImagePath.value,
                      );
                      Navigator.pop(context);
                    }, // Default to an empty function if null
                  )
                ],
              ),
            ),
          );
        }
      })
    );
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    required double screenHeight,
    required double screenWidth,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
    double height = 0.06,
  }) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.05),
      height: screenHeight * height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: tsSubHeader4(
              fontWeight: FontWeight.w700,
              screenSize: screenWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: textFormField(
              label: label,
              controller: controller,
              textInputType: keyboardType,
              validator: validator,
              labelStyle: tsParagraft3(
                color: Colors.black.withOpacity(0.3),
                screenSize: screenWidth,
              ),
              height: screenHeight * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}


