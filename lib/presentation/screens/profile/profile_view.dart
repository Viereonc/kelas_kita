import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kelas_kita/presentation/registration/login/login_view.dart';
import 'package:kelas_kita/presentation/screens/profile/about_us/about_us.dart';
import 'package:kelas_kita/presentation/screens/profile/detail_profile/detail_profile.dart';
import 'package:kelas_kita/presentation/screens/profile/edit_profile/edit_profile.dart';
import 'package:kelas_kita/presentation/screens/profile/privacy_policy/privacy_policy.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/Backdrop.dart';
import 'edit_profile/edit_profile_controller.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final EditProfileController editProfileController = Get.put(EditProfileController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.1),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: primeryColorMedium,
                      width: double.infinity,
                      height: screenHeight * 0.2,
                    ),
                    Positioned(
                      top: screenHeight * 0.1,
                      child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(80),
                                  boxShadow: [primaryBackDrop(opacity: 0.3)]
                              ),
                            ),
                          Obx(() => editProfileController.isLoading.value
                              ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: screenWidth * 0.33,
                              height: screenWidth * 0.33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[300],
                              ),
                            ),
                          ) : ClipOval(
                            child: Container(
                              width: screenWidth * 0.33,
                              height: screenWidth * 0.33,
                              child: editProfileController.selectedImagePath.value != null
                                  ? Image.file(
                                editProfileController.selectedImagePath.value!,
                                fit: BoxFit.cover,
                              )
                                  : SvgPicture.asset(
                                "libassets/images/example.svg",
                                fit: BoxFit.cover,
                                color: Colors.red,
                              ),
                            ),
                            ))
                          ]),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      Obx(() {
                        return Text('${profileController.userName}',
                            style: tsHeader3(screenSize: screenWidth)
                        );
                      }),
                      SizedBox(height: 5,),
                      Text("Anggota Kelas", style: tsSubHeader4(
                        screenSize: screenWidth,
                      ),),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                        width: double.infinity,
                        height: screenHeight * 0.13,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              primaryBackDrop(opacity: 0.085)
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight  * 0.025, horizontal: screenWidth  * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("lib/assets/icons/pe_fire.svg", color: Colors.red,),
                                  Text("80%", style: tsSubHeader4(
                                    screenSize: screenWidth,
                                  ),),
                                  Text("Pembayaran Kas", style: tsSubHeader6(
                                    screenSize: screenWidth,
                                  ),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight  * 0.025, horizontal: screenWidth  * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("lib/assets/icons/pe_watch.svg"),
                                  Text("100%", style: tsSubHeader4(
                                    screenSize: screenWidth,
                                  ),),
                                  Text("Absensi", style: tsSubHeader6(
                                    screenSize: screenWidth,
                                  ),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight  * 0.025, horizontal: screenWidth  * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("lib/assets/icons/pe_watch.svg"),
                                  Text("80%", style: tsSubHeader4(
                                    screenSize: screenWidth,
                                  ),),
                                  Text("Pembayaran Kas", style: tsSubHeader6(
                                    screenSize: screenWidth,
                                  ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.35,
                        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailProfileScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: screenWidth * 0.04),
                                        child: SvgPicture.asset(
                                          "lib/assets/icons/pe_detail.svg", width: screenWidth * 0.04, height: screenHeight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "Detail Profile",
                                        style: tsSubHeader4(fontWeight: FontWeight.bold, screenSize: screenWidth,),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: screenWidth * 0.05,
                                      )
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: screenWidth * 0.04),
                                        child: SvgPicture.asset(
                                          "lib/assets/icons/pe_edit.svg", width: screenWidth * 0.04, height: screenHeight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "Edit Profile",
                                        style: tsSubHeader4(fontWeight: FontWeight.bold, screenSize: screenWidth,),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: screenWidth * 0.05,
                                      )
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: screenWidth * 0.04),
                                        child: SvgPicture.asset(
                                          "lib/assets/icons/pe_privacy.svg", width: screenWidth * 0.04, height: screenHeight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "Privacy Policy",
                                        style: tsSubHeader4(fontWeight: FontWeight.bold, screenSize: screenWidth,),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: screenWidth * 0.05,
                                      )
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: screenWidth * 0.04),
                                        child: SvgPicture.asset(
                                          "lib/assets/icons/pe_about.svg",
                                          width: screenWidth * 0.04,
                                          height: screenHeight * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "About Us",
                                        style: tsSubHeader4(fontWeight: FontWeight.bold, screenSize: screenWidth,),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: screenHeight * 0.01),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: screenWidth * 0.05,
                                      )
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.04, top: screenHeight * 0.02),
                        child: Button(
                            label: "Log Out",
                            textStyle: tsSubHeader4(
                              screenSize: screenWidth,
                            ),
                            textColor: Colors.white,
                            backgroundColor: Color(0xFFFF2D2D),
                            side: BorderSide.none,
                            onPressed: () {
                              showCupertinoDialog<void>(
                                  context: context, builder: (BuildContext context) => CupertinoAlertDialog(
                                  title: Text('Peringatan', style: tsParagraft2(
                                    screenSize: screenWidth,
                                  ),),
                                  content: Text('Apakah anda ingin Log Out?', style: tsParagraft5(
                                    screenSize: screenWidth,
                                  ),),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(child: Text('Tidak', style: tsSubHeader4(
                                      screenSize: screenWidth,
                                    )), isDestructiveAction: true, onPressed: () {Navigator.pop(context);},),
                                    CupertinoDialogAction(child: Text('Ya', style: tsSubHeader4(
                                      screenSize: screenWidth,
                                    ).copyWith(color: Colors.red),),  onPressed: () async {
                                      profileController.logout();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginView()),
                                            (Route<dynamic> route) => false,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primeryColorMedium,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(30)
          ),
          child: Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
