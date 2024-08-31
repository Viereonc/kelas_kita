import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/profile/detail_profile/detail_profile_controller.dart';
import 'package:kelas_kita/presentation/screens/profile/edit_profile/edit_profile_controller.dart';

import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class DetailProfileScreen extends StatelessWidget {
  DetailProfileScreen({Key? key}) : super(key: key);

  final EditProfileController editProfileController = Get.put(EditProfileController());
  final DetailProfileController detailProfileController = Get.put(DetailProfileController());

  Future<void> _refreshData() async {
    await detailProfileController.fetchBiografi();
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
              "Detail Profile",
              style: tsHeader2(screenSize: screenWidth),
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
        if (detailProfileController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenHeight * 0.1),
                child: Column(
                  children: [
                    Divider(color: Colors.grey, thickness: 1),
                    Container(
                      height: screenHeight * 0.27,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.03),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Obx(() {
                                return detailProfileController.profileImageUrl.value.isNotEmpty
                                    ? Image.network(
                                  detailProfileController.profileImageUrl.value,
                                  width: screenWidth * 0.28,
                                  height: screenWidth * 0.27,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback if the network image fails to load
                                    return Icon(
                                      Icons.image_not_supported,
                                      size: screenWidth * 0.2,
                                      color: Colors.grey,
                                    );
                                  },
                                )
                                    : Center(
                                  child: SvgPicture.asset(
                                    "lib/assets/icons/pe_camera.svg",
                                    height: screenWidth * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: screenHeight * 0.05,
                            color: Colors.transparent,
                            width: double.infinity,
                            child: Obx(() {
                              return Text(
                                detailProfileController.bio.value,
                                style: tsParagraft4(screenSize: screenWidth),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
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
                                Text("Profile Informasi", style: tsHeader3(screenSize: screenWidth)),
                                Container(
                                  height: screenHeight * 0.08,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nama",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              detailProfileController.userName.value,
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kelas",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              detailProfileController.className.value,
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Container(
                            height: screenHeight * 0.27,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Informasi Siswa", style: tsHeader3(screenSize: screenWidth)),
                                Container(
                                  height: screenHeight * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "NIS",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              detailProfileController.nis.value,
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Email",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              detailProfileController.email.value,
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Nomor Telepon",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              '0${detailProfileController.phoneNumber.value}',
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Alamat",
                                            style: tsParagraft3(screenSize: screenWidth).copyWith(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                          Obx(() {
                                            return Text(
                                              detailProfileController.address.value,
                                              style: tsParagraft4(fontWeight: FontWeight.w600, screenSize: screenWidth),
                                            );
                                          }),
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
              ),
            ),
          );
        }
      }),
    );
  }
}
