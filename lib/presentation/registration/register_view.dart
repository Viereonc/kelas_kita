import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/login_view.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: tsSubHeader1(
                        screenSize: screenWidth,
                      ),
                    ),
                    Text(
                      'Register untuk melanjutkan',
                      style: tsSubHeader4(
                        screenSize: screenWidth
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset(
                  'lib/assets/images/lr_register.png',
                  width: screenWidth * 0.80,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
                child: Column(
                  children: [
                    textFormField(
                      label: "Email",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    textFormField(
                      label: "Password",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    textFormField(
                      label: "Confirm Password",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Button(
                      label: "Register",
                      textStyle: tsSubHeader4(
                        screenSize: screenWidth
                      ),
                      textColor: Colors.white,
                      backgroundColor: primeryColorMedium,
                      side: BorderSide.none,
                      onPressed: () {
                        Get.to(
                          () => LoginView(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 300),
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Sudah punya akun? Login Disini",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Button(
                      label: 'Login',
                      onPressed: () {
                        Get.to(
                          () => LoginView(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 300),
                        );
                      },
                      textColor: primeryColorMedium,
                      backgroundColor: Colors.white,
                      textStyle: tsHeader3(
                        screenSize: screenWidth
                      ),
                      side: BorderSide(color: primeryColorMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
