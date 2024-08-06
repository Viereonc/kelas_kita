import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelas_kita/data/models/biografi_model.dart';
import 'package:kelas_kita/presentation/screens/home/home_controller.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/screens/home/shimmer_home.dart';
import 'package:kelas_kita/presentation/widgets/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:shimmer/shimmer.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
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
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tagihan Kas Kelas",
                      style: tsSubHeader3(screenSize: screenWidth),
                    ),
                    Expanded(
                      child: Obx(() {
                        if (homeController.isLoading.value) {
                          return ShimmerLoadingListView(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          );
                        } else if (homeController.tagihanKasList.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak ada tagihan kas',
                              style: tsParagraft3(screenSize: screenWidth),
                            ),
                          );
                        } else {
                          // Flatten the list with tanggal as string
                          final List<Map<String, String?>> flattenedList = [];
                          homeController.tagihanKasList.forEach((tagihanKas) {
                            tagihanKas.jumlah.forEach((jumlah) {
                              flattenedList.add({
                                'tanggal': jumlah.tanggal.toString(),  // Ensure that tanggal is stored as a string
                                'nominal': jumlah.nominal,
                                'status': tagihanKas.biodata?.status,
                              });
                            });
                          });

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: flattenedList.length,
                            itemBuilder: (context, index) {
                              final item = flattenedList[index];
                              final formattedDate = item['tanggal'] != null
                                  ? DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(item['tanggal'] ?? ''))
                                  : 'Unknown Date';

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                                child: Container(
                                  padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.015, bottom: screenHeight * 0.015),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Kas Pada Tanggal $formattedDate',
                                              style: tsSubHeader4(
                                                fontWeight: FontWeight.bold,
                                                screenSize: screenWidth * 1,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              'Nominal: ${item['nominal'] ?? 'Unknown Nominal'}',
                                              style: tsParagraft4(screenSize: screenWidth).copyWith(color: Color(0xFFBE1833)),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              item['status'] == 'B' ? 'Belum Lunas' : 'Lunas',
                                              style: tsParagraft4(screenSize: screenWidth),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      })
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
