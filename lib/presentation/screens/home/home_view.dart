import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/home/home_controller.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/screens/home/shimmer_home.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import '../../themes/FontsStyle.dart';
import 'home_real_content.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02, left: screenWidth * 0.06),
                    child: Text(
                      'Hello, Ammar Faris 👋', 
                      style: tsHeader3(
                        screenSize: screenWidth
                      )
                    ),
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
              height: screenHeight * 0.386,
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
                    Text("Tagihan Kas Kelas", style: tsSubHeader3(screenSize: screenWidth)),
                    Expanded(
                      child: Obx(() => homeController.isLoading.value
                          ? ShimmerLoadingListView(screenWidth: screenWidth, screenHeight: screenHeight,
                        ) : ListView.builder(
                          itemCount: 9,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            child: Container(
                              padding: EdgeInsets.only(left: screenWidth * 0.05),
                              height: screenHeight * 0.11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: screenWidth * 0.12,
                                    width: screenWidth * 0.12,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEB4335),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.list_outlined,
                                        color: Colors.white,
                                        size: screenWidth * 0.08,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kas Pada Tanggal 3 Maret 2024',
                                        style: tsSubHeader4(
                                          fontWeight: FontWeight.bold,
                                          screenSize: screenWidth * 1,
                                        ),
                                      ),
                                      Text(
                                        'Belum Dibayar',
                                        style: tsParagraft4(screenSize: screenWidth),
                                      ),
                                      Text(
                                        'Rp.5.000',
                                        style: tsParagraft4(screenSize: screenWidth).copyWith(color: Color(0xFFBE1833)),
                                      ),
                                    ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
             Get.toNamed('/qrcodescreen'); 
          },
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
