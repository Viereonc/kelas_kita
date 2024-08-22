import 'package:flutter/material.dart';
import 'package:kelas_kita/presentation/screens/lupa_password/code_verification/code_verification.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:get/get.dart';

import '../../../widgets/TextFormField.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.02, bottom: screenHeight * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lupa Password', style: tsHeader1(screenSize: screenWidth * 0.85),),
                  Text('Ubah Password', style: tsParagraft3(screenSize: screenWidth * 0.85, color: Colors.grey.withOpacity(0.8)),),
                ],
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.5,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                decoration: BoxDecoration(
                    color: Color(0xFF7DA5E3),
                    shape: BoxShape.circle
                ),
                child: Image.asset('lib/assets/images/vector_passcode.png'),
              ),
            ),
            Container(
              height: screenHeight * 0.23,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mohon Masukan Alamat Email Anda Untuk Mendapatkan Code Verifikasi', style: tsParagraft3(screenSize: screenWidth * 0.9), textAlign: TextAlign.center,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: textFormFieldTwo(
                      label: "Password Baru",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: textFormFieldTwo(
                      label: "Konfirmasi Password",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03, top: screenHeight * 0.03),
              child: Button(
                  label: 'Kirim Verifikasi',
                  textStyle: tsSubHeader4(screenSize: screenWidth),
                  textColor: Colors.white,
                  backgroundColor: primeryColorMedium,
                  side: BorderSide.none,
                  onPressed: () {
                    Get.to(
                      () => CodeVerificationScreen(),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
