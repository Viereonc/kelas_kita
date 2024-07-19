import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/routes/app_routes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';

class RealContent extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Color primeryColorDark;
  final RxString advancedClassSchedule; 

  const RealContent({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.primeryColorDark,
    required this.advancedClassSchedule, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
          width: screenWidth * 0.003,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: screenWidth * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(13),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(13),
              ),
              color: primeryColorDark,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                    "lib/assets/icons/he_info_user.svg", width: screenWidth * 0.05,
                    height: screenHeight * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jumlah Absensi', style: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.white)),
                    Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                    Obx(() => Text(advancedClassSchedule.value, style: tsHeader2(screenSize: screenWidth).copyWith(color: Colors.white))), // Modify this line
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '30 \n Siswa',
                  style: tsParagraft2(screenSize: screenWidth),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RealIcons extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Color primeryColorDark;

  const RealIcons({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.primeryColorDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03, top: screenHeight * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildColumn(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: Color(0xFF41BEBE),
            svgAsset: "lib/assets/icons/he_info_kelas.svg",
            text: 'Kedisiplinan \n Kelas',
            onTap: () {
              Get.toNamed(Path.INFOKELAS_PAGE);
            },
          ),
          _buildColumn(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: Color(0xFFFF844F),
            svgAsset: "lib/assets/icons/he_info_tugas.svg",
            text: 'Info Tugas',
            onTap: () {
              Get.toNamed(Path.INFOTUGAS_PAGE);
            },
          ),
          _buildColumn(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: Color(0xFFFFBF43),
            svgAsset: "lib/assets/icons/he_note.svg",
            text: 'Note',
            onTap: () {
              Get.toNamed(Path.AGENDA_PAGE);
            },
          ),
          _buildColumn(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: Color(0xFF5675E3),
            svgAsset: "lib/assets/icons/he_struktur.svg",
            text: 'Struktur',
            onTap: () {
              Get.toNamed(Path.STRUKTURKELASGURU_PAGE);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColumn({
    required double screenWidth,
    required double screenHeight,
    required Color color,
    required String svgAsset,
    required String text,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
          width: screenWidth * 0.15,
          height: screenWidth * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: color,
          ),
          child: Center(
            child: GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                svgAsset,
                width: screenWidth * 0.05,
                height: screenHeight * 0.05,
              ),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.05, // Sesuaikan tinggi tetap untuk teks
          child: Text(
            text,
            style: tsSubHeader5(fontWeight: FontWeight.bold, screenSize: screenWidth),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

