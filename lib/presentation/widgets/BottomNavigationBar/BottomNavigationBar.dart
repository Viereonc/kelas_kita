import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/routes/app_routes.dart';
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
        color: Colors.transparent,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: primeryColorMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildNavBarItem(
                        0,
                        "lib/assets/icons/nb_home_new.svg",
                        "lib/assets/icons/nb_home_fill_new.svg",
                        "Home",
                        screenWidth,
                        screenHeight,
                      ),
                      buildNavBarItem(
                        1,
                        "lib/assets/icons/nb_jadwal_new.svg",
                        "lib/assets/icons/nb_jadwal_fill_new.svg",
                        "Jadwal",
                        screenWidth,
                        screenHeight,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildNavBarItem(
                        2,
                        "lib/assets/icons/nb_notif_new.svg",
                        "lib/assets/icons/nb_notif_fill_new.svg",
                        "Notice",
                        screenWidth,
                        screenHeight,
                      ),
                      buildNavBarItem(
                        3,
                        "lib/assets/icons/nb_profile_new.svg",
                        "lib/assets/icons/nb_profile_fill_new.svg",
                        "Profile",
                        screenWidth,
                        screenHeight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget buildNavBarItem(int index, String imagePath, String filledImagePath, String label, double screenWidth, double screenHeight) {
    bool isSelected = bottomNavBarController.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        bottomNavBarController.changeTabIndex(index);
        switch (index) {
          case 0:
            Get.toNamed(Path.HOME_PAGE);
            break;
          case 1:
            Get.toNamed(Path.JADWAL_PAGE);
            break;
          case 2:
            Get.toNamed(Path.NOTIFICATION_PAGE);
            break;
          case 3:
            Get.toNamed(Path.PROFILE_PAGE);
            break;
          default:
            break;
        }
      },
      child: Container(
        height: screenHeight * 0.075,
        width: screenWidth * 0.2,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.042,
              width: screenWidth * 0.05,
              child: SvgPicture.asset(
                isSelected ? filledImagePath : imagePath,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
