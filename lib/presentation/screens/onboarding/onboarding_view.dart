import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';
import 'package:kelas_kita/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: 'Selamat datang di \n Kelasku',
            body:
                'Kelola kelas dengan mudah dengan \n berbagai fitur seperti mengatur struktur \n kelas, mengelola uang kas dan masih banyak fitur lainnya',
            decoration: PageDecoration(
                titleTextStyle: tsHeader2(),
                bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300),
                bodyAlignment: Alignment.center,
                imagePadding: EdgeInsets.only(top: screenHeight * 0.03),),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        _introKey.currentState?.skipToEnd();
                      },
                      child: Text('Skip',
                          style: tsSubHeader3()),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'lib/assets/images/ob_welcome.png',
                    width: screenWidth * 0.58,
                  ),
                ),
              ],
            ),
          ),
          PageViewModel(
            title: 'Manfaat Dari Kelaskita',
            body:
                'Memudahkan para guru dan murid \n saat melakukan kegiatan pembelajaran',
            decoration: PageDecoration(
                titleTextStyle: tsHeader2(),
                bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300),
                bodyAlignment: Alignment.center,
                imagePadding: EdgeInsets.only(top: screenHeight * 0.03)),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        _introKey.currentState?.skipToEnd();
                      },
                      child: Container(
                        child: Text(
                          'Skip',
                          style: tsSubHeader3()
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'lib/assets/images/ob_benefit_kelaskita.png',
                  width: screenWidth * 0.7,
                ),
              ],
            ),
          ),
          PageViewModel(
            title: 'Manfaat Untuk \n Kedisiplinan Murid',
            body:
                'Membuat guru dan bendahara kelas \n jadi lebih mudah saat mengabsen atau \n menagih kas para murid',
            decoration: PageDecoration(
                titleTextStyle: tsHeader2(),
                bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300),
                bodyAlignment: Alignment.center,
                imageAlignment: Alignment.bottomCenter,
                imagePadding: EdgeInsets.only(top: screenHeight * 0.03)),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: screenWidth * 0.03),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        _introKey.currentState?.skipToEnd();
                      },
                      child: Text('Skip',
                          style: tsSubHeader3()),
                    ),
                  ),
                ),
                Image.asset(
                  'lib/assets/images/ob_benefit_for_students.png',
                  width: screenWidth * 0.7,
                ),
              ],
            ),
          ),
          PageViewModel(
              title: 'Keamanan yang Terpercaya',
              body:
                  'Keamanan yang teruji dan terpercaya \n serta privasi yang terjamin',
              decoration: PageDecoration(
                titleTextStyle: tsHeader2(),
                bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300),
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.bottomCenter,
                imagePadding: EdgeInsets.only(bottom: screenHeight * 0.02)),
              image: Image.asset(
                'lib/assets/images/ob_security.png',
                width: screenWidth * 0.7,
              ),
              footer: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03, left: screenWidth * 0.1, right: screenWidth * 0.1),
                    child: Container(
                      child: Button(
                        label: 'Login',
                        onPressed: () {
                          Get.toNamed(Path.LOGIN_PAGE);
                        },
                        textColor: Colors.white,
                        backgroundColor: primeryColorMedium,
                        textStyle: tsHeader3(),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03, left: screenWidth * 0.1, right: screenWidth * 0.1),
                    child: Button(
                      label: 'Register',
                      onPressed: () {
                        Get.toNamed(Path.REGISTER_PAGE);
                      },
                      textColor: primeryColorMedium,
                      backgroundColor: Colors.white,
                      textStyle: tsHeader3(),
                      side: BorderSide(color: primeryColorMedium),
                    ),
                  ),
                ],
              )),
        ],
        onDone: () {},
        controlsMargin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03, horizontal: screenWidth * 0.03),
        showSkipButton: false,
        showNextButton: true,
        showDoneButton: false,
        showBackButton: true,
        dotsDecorator: DotsDecorator(activeColor: primeryColorMedium),
        back: Icon(
          Icons.arrow_circle_left,
          color: primeryColorMedium,
          size: screenWidth * 0.08,
        ),
        next: Icon(
          Icons.arrow_circle_right,
          color: primeryColorMedium,
          size: screenWidth * 0.08,
        ),
      ),
    );
  }
}
