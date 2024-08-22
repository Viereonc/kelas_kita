import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import '../../widgets/Button.dart';
import 'kas_controller.dart';

class KasScreen extends StatelessWidget {
  KasScreen({Key? key}) : super(key: key);

  final KasController kasController = Get.put(KasController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() {
        if (kasController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.03, bottom: screenHeight * 0.03),
                  width: double.infinity,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                      color: primeryColorDark,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('lib/assets/images/vector_credit_card.png'),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.035),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Total Tunggakan Kas',
                                    style: tsParagraft4(
                                      screenSize: screenWidth,
                                    ).copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    'Rp ${kasController.tagihanKasList.isNotEmpty ? kasController.tagihanKasList.first.totalKas : "0"}',
                                    style: tsHeader2(
                                      screenSize: screenWidth,
                                    ).copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('lib/assets/images/vector_credit_card_2.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: screenWidth * 0.01),
                  child: Text(
                    "Riwayat Pembayaran Kas",
                    style: tsSubHeader3(
                      fontWeight: FontWeight.bold,
                      screenSize: screenWidth,
                    ),
                  ),
                ],
              ),
            ),               
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: screenHeight * 0.015,
                      top: screenHeight * 0.03,
                    ),
                    child: kasController.tagihanKasList.isEmpty
                        ? Center(
                      child: Text(
                        "Tidak ada riwayat kas",
                        style: tsParagraft3(
                          fontWeight: FontWeight.w500,
                          screenSize: screenWidth,
                        ).copyWith(color: Colors.black),
                      ),
                    ) : ListView.builder(
                      itemCount: kasController.tagihanKasList.length,
                      itemBuilder: (context, index) {
                        final tagihan = kasController.tagihanKasList[index];
                        return Column(
                          children: tagihan.jumlah.map((jumlahItem) {
                            // Format the date
                            String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(jumlahItem.tanggal);

                            return Container(
                              margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.13,
                                    height: screenHeight * 0.1,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF34A853),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.plus,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 2,
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 7),
                                          child: SvgPicture.asset(
                                            "lib/assets/icons/he_kas.svg",
                                            width: screenWidth * 0.033,
                                            height: screenHeight * 0.033,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kas Mingguan",
                                          style: tsParagraft3(
                                            fontWeight: FontWeight.w600,
                                            screenSize: screenWidth,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.005,
                                        ),
                                        // Display the formatted date
                                        Text(
                                          formattedDate,
                                          style: tsParagraft4(
                                            fontWeight: FontWeight.w500,
                                            screenSize: screenWidth * 0.8,
                                          ).copyWith(
                                            color: Colors.grey.withOpacity(0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Display the dynamic nominal
                                  Text(
                                    "Rp ${jumlahItem.nominal}",
                                    style: tsParagraft3(
                                      fontWeight: FontWeight.w600,
                                      screenSize: screenWidth * 0.9,
                                    ).copyWith(color: Color(0xFF34A853)),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                Button(
                    label: "Bayar Kas",
                    textStyle: tsSubHeader4(
                      screenSize: screenWidth,
                    ).copyWith(color: Colors.white),
                    textColor: Colors.white,
                    backgroundColor: primeryColorMedium,
                    side: BorderSide.none,
                    onPressed: () => kasController.openIconButtonpressed(context))
              ],
            ),
          );
        }
      }),
    );
  }
}
