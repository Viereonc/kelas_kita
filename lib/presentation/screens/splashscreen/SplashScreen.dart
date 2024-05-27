import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelas_kita/presentation/screens/splashscreen/splash_controller.dart';
import 'package:kelas_kita/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 1000),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return AnimatedOpacity(
              duration: value < 1 ? Duration(milliseconds: 100) : Duration(milliseconds: 50),
              opacity: value,
              child: Image.asset(
                width: screenWidth * 0.3,
                'lib/assets/icons/logo.png',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
