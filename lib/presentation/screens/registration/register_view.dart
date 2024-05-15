import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';
import 'package:kelas_kita/routes/app_routes.dart';


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
                      style: tsSubHeader1(),
                    ),
                    Text(
                      'Register untuk melanjutkan',
                      style: tsSubHeader4(),
                    ),
                  ],
                )
              ),
              Center(
                child: Image.asset(
                  'lib/assets/images/lr_register.png',
                  width: screenWidth * 0.80,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: textFormField(
                        label: "Email", 
                        labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3)),
                        height: screenHeight * 0.06
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: textFormField(
                        label: "Password", 
                        labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3)),
                        height: screenHeight * 0.06
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: textFormField(
                        label: "Password", 
                        labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3)),
                        height: screenHeight * 0.06
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Button(
                                label: "Register", 
                                textStyle: tsSubHeader4(), 
                                textColor: Colors.white, 
                                backgroundColor: primeryColorMedium, 
                                side: BorderSide.none, 
                                onPressed: () {
                                  Get.off(
                                    Path.LOGIN_PAGE
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                      child: Text(
                        "Sudah punya akun? Login Disini",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                      child: Button(
                      label: 'Login',
                      onPressed: () {
                        Get.off(
                          Path.LOGIN_PAGE
                        );
                      },
                      textColor: primeryColorMedium,
                      backgroundColor: Colors.white,
                      textStyle: tsHeader3(),
                      side: BorderSide(color: primeryColorMedium),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
