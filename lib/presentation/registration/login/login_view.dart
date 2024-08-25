import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kelas_kita/presentation/registration/login/login_controller.dart';
import 'package:kelas_kita/presentation/registration/register/register_view.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import '../../../constants.dart';
import '../../../routes/app_routes.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/presentation/widgets/TextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../screens/fcm_token/fcm_token.dart';
import 'google_sign_in.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (loginController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
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
                                      loginController.loginUser(
                                          loginController.emailController.text,
                                          loginController.passwordController.text
                                      );
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
                                icon: SvgPicture.asset("lib/assets/icons/google_icon.svg", fit: BoxFit.cover, width: screenWidth * 0.08,),
                                onPressed: () {
                                  signIn(context);
                                },
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
          );
        }
      }),
    );
  }

  void signIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try { 
      // Sign out any existing Google sessions
      await GoogleSignIn().signOut();

      // Sign in with Google
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();

      // If user is null, the sign-in failed
      if (user == null) {
        Get.snackbar('Error', 'Sign In Failed');
        return;
      }

      // Print the user information
      print('Username: ${user.displayName}');
      print('Email: ${user.email}');
      print('ID: ${user.id}');

      // Prepare the POST request with the required data
      final response = await http.post(
        Uri.parse(baseUrl + loginGoogleEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': user.displayName,
          'email': user.email,
          'id_google': user.id,
        }),
      );

      // Handle the response from the server
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        await prefs.setBool('isLoggedIn', true);
        final token = responseData['token'];
        final userData = responseData['user'];

        prefs.setString('isLoginGoogle', 'true');
        prefs.setString('token', token);
        prefs.setInt('id_user', userData['id_user'] ?? 0);  // Default to 0 if null
        prefs.setString('email', userData['email']);

        print('Token: $token');
        Get.snackbar('Success', 'Sign In Success', backgroundColor: Colors.green, colorText: Colors.white);
        print('Login Google Success');

        await loginController.fetchBiografi();

      } else {
        // Get.snackbar('Error', 'Sign In Failed: ${response.statusCode}');
      }
    } on PlatformException catch (e) {
      print('Error signing in with Google: $e');
      // Get.snackbar('Error', 'Sign In Failed - PlatformException');
    } catch (e) {
      print('Error signing in with Google: $e');
      // Get.snackbar('Error', 'Sign In Failed - General Exception');
    }
  }

}
