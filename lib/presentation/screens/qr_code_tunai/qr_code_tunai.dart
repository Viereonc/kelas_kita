import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_controller.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../themes/Colors.dart';
import '../../themes/FontsStyle.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanQrCodeTunaiScreen extends StatelessWidget {
  final MobileScannerController cameraController = MobileScannerController();
  final ValueNotifier<bool> isFlashOn = ValueNotifier<bool>(false);

  final KasController kasController = Get.put(KasController());

  ScanQrCodeTunaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenSize = screenWidth > screenHeight ? screenHeight : screenWidth;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Pindai Kode QR",
            style: tsHeader2(screenSize: screenSize).copyWith(color: Colors.white),
          ),
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isFlashOn,
            builder: (context, value, child) {
              return IconButton(
                icon: Icon(
                  value ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  isFlashOn.value = !isFlashOn.value;
                  cameraController.toggleTorch();
                },
              );
            },
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcodeCapture) {
              final Barcode? barcode = barcodeCapture.barcodes.first;
              final String? code = barcode?.rawValue;
              if (code != null) {
                _handleQRCodeScanned(context, code);
              }
            },
          ),
          Positioned(
            top: (screenHeight - screenWidth * 0.7) / 3,
            left: (screenWidth - screenWidth * 0.7) / 3,
            child: SvgPicture.asset(
              'lib/assets/icons/lucide_scan.svg',
              width: screenWidth * 0.7,
              height: screenWidth * 0.7,
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.035,
                  decoration: BoxDecoration(
                    color: primeryColorMedium.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Arahkan kotak pada Kode QR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: screenWidth * 0.4,
                            height: 4,
                            color: Colors.grey,
                            margin: EdgeInsets.only(bottom: 8),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Panduan Pembayaran',
                            style: tsHeader3(screenSize: screenSize).copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 34),
                        Text(
                          'Ikuti langkah-langkah ini untuk melakukan pembayaran kas secara tunai atau cash :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: '1. Lakukan pemindaian QR code yang diberikan oleh ketua kelas atau bendahara kelas.\n\n',
                              ),
                              TextSpan(
                                text: '2. Setelah melakukan pemindaian QR code, tunggu beberapa saat untuk ketua kelas atau bendahara melakukan konfirmasi uang kas.\n\n',
                              ),
                              TextSpan(
                                text: '3. Setelah pembayaran dikonfirmasi oleh ketua kelas atau bendahara, maka pembayaran sudah selesai untuk dilakukan.\n\n',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleQRCodeScanned(BuildContext context, String code) {
    final parts = code.split('\n');
    if (parts.length == 3) {
      final scannedNominal = int.tryParse(parts[1].replaceAll('Nominal: ', ''));
      final scannedIdBiodata = int.tryParse(parts[2].replaceAll('ID Biodata: ', ''));

      if (scannedNominal != null && scannedIdBiodata != null) {
        // Show the confirmation dialog
        _showConfirmationDialog(context, scannedIdBiodata, scannedNominal);
      }
    }
  }

  void _showConfirmationDialog(BuildContext context, int scannedIdBiodata, int scannedNominal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Pembayaran"),
          content: Text("Anda akan melakukan pembayaran sebesar Rp $scannedNominal.\nApakah Anda yakin?"),
          actions: <Widget>[
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text("Konfirmasi"),
              onPressed: () {
                kasController.createTransactionTunai(scannedIdBiodata, scannedNominal);
              },
            ),
          ],
        );
      },
    );
  }
}
