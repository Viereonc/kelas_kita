import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_page.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';

import 'NavbarController.dart';

class BottomNavbar extends StatelessWidget {
  final NavbarController bottomNavBarController = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: screenHeight * 0.12,
      child: Obx(() => BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    // color: Colors.black, // Warna shadow
                    // spreadRadius: 9, // Menyebar dari batas shadow
                    // blurRadius: 5, // Radius blur shadow
                    // offset: Offset(0, 30),
                  )
                ],
                color: primeryColorMedium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNavBarItem(0, "lib/assets/icons/nb_home.svg", "Home"),
                  buildNavBarItem(1, "lib/assets/icons/nb_jadwal.svg", "Jadwal"),
                  buildNavBarItem(2, "lib/assets/icons/nb_notification.svg", "Notification"),
                  buildNavBarItem(3, "lib/assets/icons/nb_profile.svg", "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(int index, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        bottomNavBarController.changeTabIndex(index);
        switch (index) {
          case 0:
            Get.to(() => HomeScreen());
            break;
          case 1:
            Get.to(() => JadwalView());
            break;
          case 2:
            Get.to(() => NotificationPage());
            break;
          case 3:
            Get.to(() => ProfileScreen());
            break;
          default:
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imagePath),
          Text(
            label,
            style: TextStyle(
              color: bottomNavBarController.selectedIndex.value == index
                  ? Colors.white
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
