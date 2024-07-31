import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_controller.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';

import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';

import '../../widgets/BottomNavigationBarGuru/BottomNavigationBar.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotifController notifController = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Notification',
                    style: tsParagraft1(
                      fontWeight: FontWeight.w600,
                      screenSize: screenWidth
                    )
                  ),
                  SvgPicture.asset(
                    "lib/assets/icons/adjusments.svg",
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                                  child: SvgPicture.asset(
                                    "lib/assets/icons/task.svg",
                                    width: screenWidth * 0.12,
                                    height: screenWidth * 0.12
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.5,
                                      child: Text(
                                        'Tagihan Uang Kas',
                                        style: tsParagraft3(
                                          fontWeight: FontWeight.w600,
                                          screenSize: screenWidth
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.5,
                                      child: Text(
                                        'Tagihan Kas Anda Bulan Ini Belum Lunas (Rp. 10.000.00)',
                                        style: tsParagraft5(screenSize: screenWidth)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              '2 hari lalu',
                              style: tsParagraft5(
                                screenSize: screenWidth
                              )
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
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
      bottomNavigationBar: Obx(() {
        if (notifController.userStatus.value == 'Wali Kelas') {
          return BottomNavbarGuru();
        } else {
          return BottomNavbar();
        }
      }),
    );
  }
}