import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 800),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return AnimatedOpacity(
              duration: value < 0.2 ? Duration(milliseconds: 200) : Duration(milliseconds: 100),
              opacity: value,
              child: Image.asset(
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
