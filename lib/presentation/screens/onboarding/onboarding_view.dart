import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kelas_kita/presentation/themes/Colors.dart';
import 'package:kelas_kita/presentation/themes/FontsStyle.dart';
import 'package:kelas_kita/presentation/widgets/Button.dart';

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
            body: 'Kelola kelas dengan mudah dengan \n berbagai fitur seperti mengatur struktur \n kelas, mengelola uang kas dan masih banyak \n fitur lainnya',
            decoration: PageDecoration(titleTextStyle: tsHeader2(), bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300)),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('data', style: TextStyle(color: Colors.white),),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {_introKey.currentState?.skipToEnd();},
                        child: const Text('Skip', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/images/ob_welcome.png', width: 400,),
              ],
            ),
          ),
          PageViewModel(
            title: 'Manfaat Dari Kelaskita',
            body: 'Memudahkan para guru dan murid \n saat melakukan kegiatan pembelajaran',
            decoration: PageDecoration(titleTextStyle: tsHeader2(), bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300)),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('data', style: TextStyle(color: Colors.white),),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {_introKey.currentState?.skipToEnd();},
                        child: const Text('Skip', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/images/ob_welcome.png', width: 400,),
              ],
            ),
          ),
          PageViewModel(
            title: 'Manfaat Untuk \n Kedisiplinan Murid',
            body: 'Membuat guru dan bendahara kelas \n jadi lebih mudah saat mengabsen atau \n menagih kas para murid',
            decoration: PageDecoration(titleTextStyle: tsHeader2(), bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300)),
            image: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('data', style: TextStyle(color: Colors.white),),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {_introKey.currentState?.skipToEnd();},
                        child: const Text('Skip', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/images/ob_welcome.png', width: 400,),
              ],
            ),
          ),
          PageViewModel(
              title: 'Keamanan yang Terpercaya',
              body: 'Keamanan yang teruji dan terpercaya \n serta privasi yang terjamin',
              decoration: PageDecoration(titleTextStyle: tsHeader2(), bodyTextStyle: tsParagraft3(fontWeight: FontWeight.w300)),
              image: Image.asset('assets/onboarding.png'),
              footer: Column(
                children: [
                  CustomButton(label: 'Login', onPressed: () {}, textColor: Colors.white, backgroundColor: primeryColorMedium, textStyle: tsHeader3(), side: BorderSide.none,),
                  SizedBox(height: 25,),
                  CustomButton(label: 'Register', onPressed: () {}, textColor: primeryColorMedium, backgroundColor: Colors.white, textStyle: tsHeader3(), side: BorderSide(color: primeryColorMedium),),
                ],
              )),
        ],
        onDone: () {},
        controlsMargin: EdgeInsets.only(top: screenHeight * 0.03, bottom: screenHeight * 0.03),
        showSkipButton: false,
        showNextButton: true,
        showDoneButton: false,
        showBackButton: true,
        dotsDecorator: DotsDecorator(activeColor: primeryColorMedium),
        back: const Icon(Icons.arrow_circle_left, color: primeryColorMedium, size: 25,),
        next: const Icon(Icons.arrow_circle_right, color: primeryColorMedium, size: 25,),
      ),
    );
  }
}
