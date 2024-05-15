import 'package:flutter/material.dart';
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
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: AppBar(
                surfaceTintColor: Colors.white,
                title: Text(
                  "Kas",
                  style: tsHeader2(),
                ),
                centerTitle: true,
                leading: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        color: primeryColorMedium,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white
                        )
                      ),
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
              margin: EdgeInsets.only(top: screenHeight * 0.03, bottom: screenHeight * 0.03),
              width: double.infinity,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                  color: primeryColorDark,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.035),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Tunggakan Kas', 
                          style: tsParagraft4().copyWith(color: Colors.white),
                        ),
                        Text(
                          'Rp 50.000', 
                          style: tsHeader2().copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.01),
              child: Text(
                "Riwayat Pembayaran Kas", 
                style: tsSubHeader3(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                child: ListView.builder(
                  itemCount: kasController.paymentHistory.length,
                  itemBuilder: (context, index) {
                    String month = kasController.paymentHistory.keys.elementAt(index);
                    List<String> payments = kasController.paymentHistory[month] ?? [];
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              color : Color(0xFFE8E8E8),
                              borderRadius: BorderRadius.circular(45)
                            ),
                            child: Center(
                              child: Text(
                                month,
                                style: tsParagraft3(fontWeight: FontWeight.w600)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: screenHeight * 0.05),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: payments.length,
                              itemBuilder: (context, paymentIndex) {
                                String payment = payments[paymentIndex];
                                return Container(
                                  child: ListTile(
                                    leading: Container(
                                      width: screenWidth * 0.1,
                                      height: screenHeight * 0.1,
                                      decoration: BoxDecoration(
                                        color : Color(0xFF34A853),
                                        shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.monetization_on_rounded, color: Colors.white,),
                                    ),
                                    title: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Kas Mingguan", 
                                              style: tsParagraft3(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: screenHeight * 0.005,),
                                            Text(
                                              payment, 
                                              style: tsParagraft5(fontWeight: FontWeight.w600).copyWith(color: Colors.grey.withOpacity(0.9)),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Rp10.000", style: tsParagraft3(fontWeight: FontWeight.bold).copyWith(color: Color(0xFF34A853)),
                                        )
                                      ],
                                    ),

                                  ),
                                );
                              },
                              separatorBuilder: (context, paymentIndex) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: screenHeight * 0.01),
                                child: Divider(
                                  thickness: 2, 
                                  color: Color(0xFFF2F2F2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Button(
              label: "Bayar Kas", 
              textStyle: tsSubHeader4().copyWith(color: Colors.white), 
              textColor: Colors.white, 
              backgroundColor: primeryColorMedium, 
              side: BorderSide.none, 
              onPressed: () => kasController.openIconButtonpressed(context)
            )
          ],
        ),
      ),
    );
  }
}
