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
  final ScanAbsensiController scanAbsensiController =
      Get.put(ScanAbsensiController());

  ScanQrAbsensi({super.key});

  void handleQRCode(String code) {
    // Log QR code data
    print('QR Code Data: $code');

    // Add a guard clause to avoid processing the same code multiple times
    if (scanAbsensiController.isLoading.value) return;

    if (scanAbsensiController.scannedData.isNotEmpty) {
      if (!scanAbsensiController.dialogShown.value) {
        scanAbsensiController.dialogShown.value = true;
        Get.dialog(ScannedDataDialog());
      }
    }

    final data = scanAbsensiController.parseScannedData(code);
    if (data != null) {
      scanAbsensiController.setScannedData(code);
    } else {
      print("Failed to parse scanned data");
    }
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
            style:
                tsHeader2(screenSize: screenSize).copyWith(color: Colors.white),
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

class ScannedDataDialog extends StatelessWidget {
  final ScanAbsensiController scanAbsensiController =
      Get.put(ScanAbsensiController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text('Data yang Dipindai'),
      content: Obx(() {
        if (scanAbsensiController.scannedData.isEmpty) {
          return Text('Tidak ada data yang dipindai');
        } else {
          final data = scanAbsensiController.scannedData;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${data["nama"] ?? 'Tidak tersedia'}'),
              SizedBox(
                height: 5,
              ),
              Text('Kelas: ${data["kelas"] ?? 'Tidak tersedia'}'),
              SizedBox(
                height: 5,
              ),
              Text('Waktu Absen: ${data["waktu_absen"] ?? 'Tidak tersedia'}'),
              SizedBox(
                height: 10,
              ),
              // Tambahkan mark merah jika telat
              if (scanAbsensiController.isLate.value)
                Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Telat',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
      }),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                scanAbsensiController.dialogShown.value =
                    false; // Reset the flag
                Get.back(); // Close dialog
              },
              child: Text(
                'Batal',
                style: tsParagraft4(
                    screenSize: screenWidth, color: primeryColorMedium),
              ),
            ),
            Row(
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    backgroundColor: Colors.red,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    scanAbsensiController.isLate.value = true;
                    scanAbsensiController.postAbsensi();
                    scanAbsensiController.dialogShown.value = false; 
                    Get.back(); // Close dialog
                  },
                  child: Text(
                    'Telat',
                    style: tsParagraft4(
                        screenSize: screenWidth, color: Colors.white),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    backgroundColor: primeryColorMedium,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    scanAbsensiController.isLate.value = false;
                    scanAbsensiController.postAbsensi();
                    scanAbsensiController.dialogShown.value = false; 
                    Get.back(); // Close dialog
                  },
                  child: Text(
                    'Terima',
                    style: tsParagraft4(
                        screenSize: screenWidth * 1, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
