import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/login/login_view.dart';
import 'package:kelas_kita/presentation/registration/register/register_controller.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

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
                      label: "Username",
                      controller: registerController.usernameController,
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    textFormField(
                      label: "Email",
                      controller: registerController.emailController,
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    textFormField(
                      controller: registerController.passwordController,
                      label: "Password",
                      labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                      height: screenHeight * 0.06,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    textFormField(
                      controller: registerController.nomorTeleponController,
                      label: "Nomor Telepon",
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
                        registerController.registerUser(registerController.usernameController.text, registerController.emailController.text, registerController.passwordController.text, registerController.nomorTeleponController.text);
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
