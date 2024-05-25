import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/login/login_controller.dart';
import 'package:kelas_kita/presentation/registration/register/register_view.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

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
                      'Login untuk melanjutkan',
                      style: tsSubHeader4(
                        screenSize: screenWidth
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset(
                  'lib/assets/images/lr_login.png',
                  width: screenWidth * 0.80,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: textFormField(
                        label: "Email",
                        controller: loginController.emailController,
                        labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                        height: screenHeight * 0.06,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: textFormField(
                        label: "Password",
                        controller: loginController.passwordController,
                        labelStyle: tsParagraft3(color: Colors.black.withOpacity(0.3), screenSize: screenWidth),
                        height: screenHeight * 0.06,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                            child: Text(
                              "Forgot Password?",
                              style: tsParagraft3(color: primeryColorMedium, screenSize: screenWidth),
                            ),
                          ),
                          Column(
                            children: [
                              Button(
                                label: "Login",
                                textStyle: tsSubHeader4(
                                  screenSize: screenWidth
                                ),
                                textColor: Colors.white,
                                backgroundColor: primeryColorMedium,
                                side: BorderSide.none,
                                onPressed: () {
                                  loginController.loginUser(loginController.emailController.text, loginController.passwordController.text);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(color: Colors.black, thickness: 1)),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Text(
                              'atau login dengan',
                              style: tsParagraft3(
                                screenSize: screenWidth
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.black, thickness: 1)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                            iconSize: screenWidth * 0.11,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                            iconSize: screenWidth * 0.11,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: Text(
                        "Tidak punya akun? register disini",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                      child: Button(
                        label: 'Register',
                        onPressed: () {
                          Get.to(
                            () => RegisterView(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 300),
                          );
                        },
                        textColor: primeryColorMedium,
                        backgroundColor: Colors.white,
                        textStyle: tsHeader3(
                          screenSize: screenWidth
                        ),
                        side: BorderSide(
                          color: primeryColorMedium
                        ),
                      ),
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
