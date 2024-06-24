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

  const RealContent({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.primeryColorDark,
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
                    "lib/assets/icons/he_cash.svg", width: screenWidth * 0.05,
                    height: screenHeight * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Kas Kelas 11 PPLG 2', style: tsParagraft4(screenSize: screenWidth).copyWith(color: Colors.white)),
                    Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                    Text('Rp 100.000', style: tsHeader2(screenSize: screenWidth).copyWith(color: Colors.white)),
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
                  'Pembukuan \n Kas',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Path.PEMBUKUAN_PAGE); // Adjust the path as needed
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_rounded,
                    size: screenWidth * 0.08,
                    color: primeryColorDark,
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
      margin: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03, top: screenHeight * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF41BEBE),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Path.INFOKELAS_PAGE);
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/he_info_kelas.svg",
                      width: screenWidth * 0.05,
                      height: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Text(
                'Info Kelas',
                style: tsSubHeader5(
                    fontWeight: FontWeight.bold, screenSize: screenWidth),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFFFF844F),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Path.INFOTUGAS_PAGE);
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/he_info_tugas.svg",
                      width: screenWidth * 0.05,
                      height: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Text(
                'Info Tugas',
                style: tsSubHeader5(
                    fontWeight: FontWeight.bold, screenSize: screenWidth),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF3EB67B),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Path.KAS_PAGE);
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/he_kas.svg",
                      width: screenWidth * 0.05,
                      height: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Text(
                'Kas',
                style: tsSubHeader5(
                    fontWeight: FontWeight.bold, screenSize: screenWidth),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFFFFBF43),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Path.AGENDA_PAGE);
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/he_note.svg",
                      width: screenWidth * 0.05,
                      height: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Text(
                'Note',
                style: tsSubHeader5(
                    fontWeight: FontWeight.bold, screenSize: screenWidth),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF5675E3),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Path.STRUKTURKELAS_PAGE);
                    },
                    child: SvgPicture.asset(
                      "lib/assets/icons/he_struktur.svg",
                      width: screenWidth * 0.05,
                      height: screenHeight * 0.05,
                    ),
                  ),
                ),
              ),
              Text(
                'Struktur',
                style: tsSubHeader5(
                    fontWeight: FontWeight.bold, screenSize: screenWidth),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

