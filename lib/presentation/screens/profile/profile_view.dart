import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';

import '../../themes/Backdrop.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                        Container(
                          width: screenWidth * 0.33,
                          height: screenWidth * 0.33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              image: DecorationImage(
                                image: NetworkImage("https://picsum.photos/500/300"),
                                fit: BoxFit.cover
                              )
                          ),
                        ),
                      ]),
                    ),
                    Positioned(
                      top: screenHeight * 0.24,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.085,
                            height: screenWidth * 0.085,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: primeryColorMedium
                              ),
                            child: Icon(Icons.edit, color: Colors.white,),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      Text("Ammar Faris", style: tsHeader3(),),
                      SizedBox(height: 5,),
                      Text("Anggota Kelas", style: tsSubHeader4(),),
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
                                  Text("80%", style: tsSubHeader4(),),
                                  Text("Pembayaran Kas", style: tsSubHeader6(),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight  * 0.025, horizontal: screenWidth  * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("lib/assets/icons/pe_watch.svg"),
                                  Text("100%", style: tsSubHeader4(),),
                                  Text("Absensi", style: tsSubHeader6(),),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: screenHeight  * 0.025, horizontal: screenWidth  * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("lib/assets/icons/pe_watch.svg"),
                                  Text("80%", style: tsSubHeader4(),),
                                  Text("Pembayaran Kas", style: tsSubHeader6(),),
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
                            Row(
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
                                      style: tsSubHeader4(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: screenHeight * 0.01),
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: screenWidth * 0.05,
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            Row(
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
                                      style: tsSubHeader4(fontWeight: FontWeight.bold),
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
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            Row(
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
                                      style: tsSubHeader4(fontWeight: FontWeight.bold),
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
                            Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            Row(
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
                                      style: tsSubHeader4(fontWeight: FontWeight.bold),
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
                          textStyle: tsSubHeader4(), 
                          textColor: Colors.white, 
                          backgroundColor: Color(0xFFFF2D2D), 
                          side: BorderSide.none, 
                          onPressed: () {}
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
