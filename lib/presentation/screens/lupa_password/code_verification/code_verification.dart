import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_kita/presentation/screens/lupa_password/ubah_password/ubah_password.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:get/get.dart';

class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({Key? key}) : super(key: key);

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
                  Text('Masukan Verifikasi', style: tsParagraft3(screenSize: screenWidth * 0.85, color: Colors.grey.withOpacity(0.8)),),
                ],
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.5,
                decoration: BoxDecoration(
                    color: Color(0xFF7DA5E3),
                    shape: BoxShape.circle
                ),
                child: Image.asset('lib/assets/images/vector_feedback.png'),
              ),
            ),
            Container(
              height: screenHeight * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mohon Masukan 4 Kode Verifikasi Yang Sudah Di Kirim Sebelumnya', style: tsParagraft3(screenSize: screenWidth * 0.9), textAlign: TextAlign.center,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildVerificationCodeField(context),
                        _buildVerificationCodeField(context),
                        _buildVerificationCodeField(context),
                        _buildVerificationCodeField(context),
                      ],
                    ),
                  )
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
                      () => ChangePasswordScreen(),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCodeField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.15,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.8),
              width: 1.5,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.5),
              width: 1.5,
            ),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
