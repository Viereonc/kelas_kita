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

  Widget buildNavBarItem(int index, String imagePath, String filledImagePath,
      String label, double screenWidth, double screenHeight) {
    bool isSelected = bottomNavBarController.selectedIndex.value == index;

    return Builder(builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (index == 1) {
            showJadwalPopup(context);
          } else {
            bottomNavBarController.changeTabIndex(index);
            switch (index) {
              case 0:
                Get.toNamed(Path.HOME_PAGE);
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
    });
  }

  void showJadwalPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pilih Jadwal',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                  fontFamily: 'Poppins', // Apply Poppins font
                ),
              ),
              SizedBox(height: 15),
              ListTile(
                leading:
                    Icon(Icons.schedule, size: 36, color: Colors.blueAccent),
                title: Text(
                  'Jadwal Pembelajaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins', // Apply Poppins font
                  ),
                ),
                onTap: () {
                  Get.toNamed(Path.JADWAL_PAGE);
                },
              ),
              Divider(thickness: 1.5, color: Colors.grey.shade300),
              ListTile(
                leading: Icon(Icons.work, size: 36, color: Colors.orangeAccent),
                title: Text(
                  'Jadwal Piket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins', // Apply Poppins font
                  ),
                ),
                onTap: () {
                  Get.toNamed(Path.JADWALPIKET);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
