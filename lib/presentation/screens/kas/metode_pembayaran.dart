import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

import '../qr/qr_code.dart';

class MetodePembayaran extends StatelessWidget {
  const MetodePembayaran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // color: Colors.white,
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
              child: ListView.separated(
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> items = [
                    {
                      'image': 'lib/assets/images/logos_dana.png',
                      'title': 'Dana',
                    },
                    {
                      'image': 'lib/assets/images/logos_qris.png',
                      'title': 'QRIS',
                    },
                    {
                      'image': 'lib/assets/icons/cash.png',
                      'title': 'Tunai',
                      'description': 'Minimal pembayaran tunai Rp 10.000',
                    },
                  ];

                  final item = items[index];

                  return InkWell(
                    onTap: () {
                      if (item['title'] == 'QRIS') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QrCodeScreen()),
                        );
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
                itemCount: 3, // Updated item count
              ),
            ),
          ],
        ),
      ),
    );
  }
}
