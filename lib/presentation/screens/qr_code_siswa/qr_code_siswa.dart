import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'qr_code_siswa_controller.dart';

class QrCodeSiswaScreen extends StatelessWidget {
  QrCodeSiswaScreen({Key? key}) : super(key: key);

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
                          child: Obx(() {
                            final pelajaran = qrCodeSiswaController.selectedPelajaran.value;
                            if (pelajaran.isEmpty) {
                              return Text(
                                'Pilih Pelajaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              );
                            }
                            return QrImageView(
                              data: qrCodeSiswaController.qrData.value,
                              version: QrVersions.auto,
                              size: screenHeight * 0.3,
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        final pelajaran = qrCodeSiswaController.selectedPelajaran.value;
                        return Text(
                          'Pelajaran : $pelajaran',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        );
                      }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Pilih Pelajaran'),
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                content: Obx(() {
                                  return SizedBox(
                                    width: double.maxFinite,
                                    height: 100,
                                    child: ListView.builder(
                                      itemCount: qrCodeSiswaController.jadwalKelasList.length,
                                      itemBuilder: (context, index) {
                                        final pelajaran = qrCodeSiswaController.jadwalKelasList[index];
                                        return ListTile(
                                          title: Text(pelajaran.namaPelajaran),
                                          onTap: () {
                                            qrCodeSiswaController.setSelectedPelajaran(
                                              pelajaran.namaPelajaran,
                                              pelajaran.idPelajaran,
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Tutup'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'Pilih Pelajaran',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
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
