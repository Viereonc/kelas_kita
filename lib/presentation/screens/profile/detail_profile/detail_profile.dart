import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/profile/edit_profile/edit_profile_controller.dart';

import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class DetailProfileScreen extends StatelessWidget {
  DetailProfileScreen({Key? key}) : super(key: key);

  final EditProfileController editProfileController = Get.put(EditProfileController());

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
              "Detail Profile",
              style: tsHeader2(),
            ),
            centerTitle: true,
            leading: Container(
              child: IconButton(
                onPressed: () {Navigator.pop(context);},
                icon: Container(
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child:
                      Icon(Icons.arrow_back_ios_new, color: Colors.white)),
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
          return Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenHeight * 0.1),
            child: Column(
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  height: screenHeight * 0.27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: editProfileController.selectedImagePath.value != null ?
                                FileImage(editProfileController.selectedImagePath.value!) :
                                NetworkImage("https://picsum.photos/500/300") as ImageProvider
                            )
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.05,
                        color: Colors.transparent,
                        width: double.infinity,
                        child: Obx(() => Text(editProfileController.ctrBio.toString(), style: tsParagraft4(), maxLines: 3,)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03,),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.15,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Profile Informasi", style: tsHeader3(),),
                            Container(
                              height: screenHeight * 0.08,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nama", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text("Ammar Faris", style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Kelas", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text("11 PPLG 2", style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03,),
                      Container(
                        height: screenHeight * 0.27,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Informasi Siswa", style: tsHeader3(),),
                            Container(
                              height: screenHeight * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("NIS", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text("0510", style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Email", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text(editProfileController.ctrEmail.value, style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nomor Telepon", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text(editProfileController.ctrPhone.toString(), style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Alamat", style: tsParagraft3().copyWith(color: Colors.grey.withOpacity(0.9)),),
                                      Text(editProfileController.ctrAddress.value, style: tsParagraft4(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      })
    );
  }
}
