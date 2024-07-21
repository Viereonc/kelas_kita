import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/screens/guru/scan_qr_absensi/scan_absensi_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../themes/Colors.dart';
import '../../../themes/FontsStyle.dart';

class ScanQrAbsensi extends StatelessWidget {
  final MobileScannerController cameraController = MobileScannerController();
  final ValueNotifier<bool> isFlashOn = ValueNotifier<bool>(false);
  final ScanAbsensiController scanAbsensiController = Get.put(ScanAbsensiController());

  ScanQrAbsensi({super.key});

  void handleQRCode(String code) async {
    await scanAbsensiController.postAbsensi(code);
  }

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
              if (code != null && !scanAbsensiController.isLoading.value) {
                handleQRCode(code);
              }
            },
          ),
          Obx(() {
            if (scanAbsensiController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox.shrink();
          }),
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
        ],
      ),
    );
  }
}
