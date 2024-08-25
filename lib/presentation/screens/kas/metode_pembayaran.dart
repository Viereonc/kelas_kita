import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_controller.dart';
import 'package:kelas_kita/presentation/screens/kas/widgets/pop_up.dart';
import 'package:kelas_kita/presentation/screens/kas/widgets/pop_up_cashless.dart';
import 'package:kelas_kita/presentation/screens/kas/widgets/qr_code.dart';
import 'package:kelas_kita/presentation/screens/qr_code_tunai/qr_code_tunai.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kelas_kita/data/services/token_services.dart';

import '../../themes/FontsStyle.dart';

class MetodePembayaran extends StatelessWidget {
  MetodePembayaran({Key? key}) : super(key: key);

  final KasController kasController = Get.put(KasController());

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight / 2.5,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "Pilih Metode Pembayaran",
                  style: tsSubHeader3(screenSize: screenWidth),
                ),
              ),
            ),
            Text(
              "e-wallet",
              style: tsSubHeader4(fontWeight: FontWeight.bold, screenSize: screenWidth),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Untuk pembayaran secara online dikenakan pajak 10.000",
              style: tsSubHeader5(fontWeight: FontWeight.bold, screenSize: screenWidth).copyWith(color: Colors.grey),
            ),
            SizedBox(height: screenHeight * 0.04),
            Expanded(
              child: Obx(() {
                // List of payment methods
                List<Map<String, dynamic>> items = [
                  {
                    'image': 'lib/assets/images/logos_qris.png',
                    'title': 'Cashless',
                    'description': 'Minimal pembayaran tunai Rp 10.000',
                  },
                ];

                if (kasController.userStatus.value != 'Wali Kelas') {
                  items.add({
                    'image': 'lib/assets/icons/cash.png',
                    'title': 'Tunai',
                  });
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return InkWell(
                      onTap: () async {
                        if (item['title'] == 'Cashless') {
                          showCashLessPopup(context);
                        } else if (item['title'] == 'Tunai') {
                          if (kasController.userStatus.value == 'Bendahara') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanQrCodeTunaiScreen(),
                              ),
                            );
                          } else {
                            showGopayPopup(context);
                          }
                        }
                      },
                      child: ListTile(
                        leading: Image.asset(
                          item['image'],
                          width: 60.0,
                          height: 60.0,
                        ),
                        title: Text(
                          item['title'],
                          style: tsSubHeader4(screenSize: screenWidth),
                        ),
                        subtitle: item.containsKey('description')
                            ? Text(
                          item['description'],
                          style: tsSubHeader5(screenSize: screenWidth).copyWith(color: Colors.grey),
                        )
                            : null,
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.05),
                    child: Divider(),
                  ),
                  itemCount: items.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
