import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/screens/qr_code_siswa/qr_code_siswa_controller.dart';

class QrCodeSiswaScreen extends StatelessWidget {
  QrCodeSiswaScreen({Key? key}) : super(key: key);

  final MobileScannerController cameraController = MobileScannerController();
  final QrCodeSiswaController qrCodeSiswaController = Get.put(QrCodeSiswaController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Text(
                "Absen QR Code",
                style: tsHeader2(screenSize: screenWidth),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: primeryColorMedium,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
              child: Container(
                height: screenHeight * 0.55,
                width: screenWidth * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scan Disini',
                        style: tsSubHeader4(
                          screenSize: screenWidth,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: MobileScanner(
                            controller: cameraController,
                            onDetect: (barcodeCapture) {
                              final Barcode? barcode = barcodeCapture.barcodes.first;
                              final String? code = barcode?.rawValue;
                              if (code != null) {
                                Navigator.pop(context, code);
                              }
                            },
                          ),
                        ),
                      ),
                      Obx(() {
                        return Column(
                          children: qrCodeSiswaController.biografiList.map((biografi) {
                            return ListTile(
                              title: Text(
                                biografi.nama,
                                style: tsSubHeader3(
                                  screenSize: screenWidth * 0.8,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                biografi.kelas.nama,
                                style: tsSubHeader3(
                                  screenSize: screenWidth * 0.8,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
