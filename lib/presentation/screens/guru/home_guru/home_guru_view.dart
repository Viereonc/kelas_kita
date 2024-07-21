import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/home/global_controller.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import '../../../themes/FontsStyle.dart';
import '../../guru/home_guru/shimmer_home.dart';
import 'home_real_content.dart';

class HomeScreenGuru extends StatelessWidget {
  HomeScreenGuru({Key? key}) : super(key: key);

  final GlobalController homeController = Get.put(GlobalController());

  final List<Map<String, String>> teachingSchedule = [
    {'class': '11 PPLG 1', 'time': '08:00 - 08:40'},
    {'class': '12 PPLG 2', 'time': '09:00 - 09:40'},
    {'class': '10 Animasi 2', 'time': '10:00 - 10:40'},
    {'class': '11 Animasi 1', 'time': '11:00 - 11:40'},
    {'class': '10 PPLG 1', 'time': '12:00 - 12:40'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenHeight * 0.02, left: screenWidth * 0.04),
                    child: Obx(() => Text('Hello, ${homeController.userName.value} 👋',
                        style: tsHeader3(screenSize: screenWidth))),
                  ),
                  Obx(() => homeController.isLoading.value
                      ? ShimmerLoadingContainer1(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          primeryColorDark: primeryColorDark,
                        )
                      : RealContent(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          primeryColorDark: primeryColorDark,
                          advancedClassSchedule: homeController.advancedClassSchedule,
                        )),
                  Obx(() => homeController.isLoading.value
                      ? ShimmerLoadingIcons(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        )
                      : RealIcons(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          primeryColorDark: primeryColorDark,
                        )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.450,
              decoration: BoxDecoration(
                  color: Color(0xFFF8F4F3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jadwal Mengajar Hari Ini",
                        style: tsSubHeader3(
                            screenSize: screenWidth,
                            fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Obx(() => homeController.isLoading.value
                          ? ShimmerLoadingListView(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            )
                          : ListView.builder(
                              itemCount: teachingSchedule.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.05),
                                    height: screenHeight * 0.11,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.38,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: screenWidth * 0.12,
                                                width: screenWidth * 0.12,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEB4335),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.list_outlined,
                                                    color: Colors.white,
                                                    size: screenWidth * 0.08,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    teachingSchedule[index]
                                                        ['class']!,
                                                    style: tsSubHeader4(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      screenSize:
                                                          screenWidth * 1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    teachingSchedule[index]
                                                        ['time']!,
                                                    style: tsParagraft4(
                                                            screenSize:
                                                                screenWidth)
                                                        .copyWith(
                                                            color: Color(
                                                                0xFFBE1833)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: screenWidth * 0.12,
                                          width: screenWidth * 0.23,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              homeController.advanceSchedule(
                                                  teachingSchedule[index]['class']!);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  primeryColorMedium,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Majukan Jadwal',
                                                style: tsParagraft4(
                                                    screenSize:
                                                        screenWidth * 1,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/qrcodeguruscreen');
          },
          backgroundColor: primeryColorMedium,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(30)),
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