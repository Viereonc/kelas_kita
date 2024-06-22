import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Kas",
                style: tsHeader2().copyWith(fontSize: screenWidth * 0.045),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              width: double.infinity,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: primeryColorDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.001,
                    top: screenHeight * 0.02,
                    child: SvgPicture.asset(
                      'lib/assets/icons/undraw.svg',
                      color: Colors.white,
                      width: screenWidth * 0.2, // Adjusted size
                      height: screenWidth * 0.2, // Adjusted size
                    ),
                  ),
                  Positioned(
                    right: screenWidth * 0.001,
                    top: screenHeight * 0.02,
                    child: SvgPicture.asset(
                      'lib/assets/icons/undraw2.svg',
                      color: Colors.white,
                      width: screenWidth * 0.2, // Adjusted size
                      height: screenWidth * 0.2, // Adjusted size
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Tunggakan Kas',
                          style: tsParagraft4().copyWith(color: Colors.white, fontSize: screenWidth * 0.04),
                        ),
                        Text(
                          'Rp 50.000',
                          style: tsHeader2().copyWith(color: Colors.white, fontSize: screenWidth * 0.055),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                "Riwayat Pembayaran Kas",
                style: tsSubHeader3(fontWeight: FontWeight.bold).copyWith(fontSize: screenWidth * 0.04),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: kasController.paymentHistory.length,
                itemBuilder: (context, index) {
                  String month = kasController.paymentHistory.keys.elementAt(index);
                  List<String> payments = kasController.paymentHistory[month] ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.01),
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.005),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8E8E8),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Text(
                          month,
                          style: tsParagraft3(fontWeight: FontWeight.w600).copyWith(fontSize: screenWidth * 0.035),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: payments.length,
                        itemBuilder: (context, paymentIndex) {
                          String payment = payments[paymentIndex];
                          return ListTile(
                            leading: Container(
                              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Color(0xFF34A853),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    'lib/assets/icons/+.svg',
                                    width: screenWidth * 0.03,
                                    fit: BoxFit.fill,
                                    height: screenWidth * 0.03,
                                  ),
                                  SvgPicture.asset(
                                    'lib/assets/icons/money_icon.svg',
                                    width: screenWidth * 0.05,
                                    fit: BoxFit.fill,
                                    height: screenWidth * 0.05,
                                  ),
                                ],
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kas Mingguan",
                                  style: tsParagraft3(fontWeight: FontWeight.bold).copyWith(fontSize: screenWidth * 0.035),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  "Gopay · 14 Maret 2024 08.45 AM",
                                  style: tsParagraft5(fontWeight: FontWeight.w600).copyWith(color: Colors.grey.withOpacity(0.9), fontSize: screenWidth * 0.03),
                                ),
                              ],
                            ),
                            trailing: Text(
                              "Rp10.000",
                              style: tsParagraft3(fontWeight: FontWeight.bold).copyWith(color: Color(0xFF34A853), fontSize: screenWidth * 0.035),
                            ),
                          );
                        },
                        separatorBuilder: (context, paymentIndex) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.005),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFF2F2F2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: double.infinity,
              child: Button(
                label: "Bayar Kas",
                textStyle: tsSubHeader4().copyWith(color: Colors.white, fontSize: screenWidth * 0.04),
                textColor: Colors.white,
                backgroundColor: primeryColorMedium,
                side: BorderSide.none,
                onPressed: () => kasController.openIconButtonpressed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
