import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:saxovat/pages/sign_in_page.dart';
import 'package:saxovat/pages/splash_page.dart';
import 'package:saxovat/views/font.dart';

class AboutProjectPage extends StatelessWidget {
  AboutProjectPage({Key? key}) : super(key: key);
  final List<Introduction> list = [
    Introduction(
      title: 'Ehson',
      subTitle:
          "Hayriya so'ngan qalblarni porlatishi, qurigan daraxtlarni yashnatishi mumkin",
      imageUrl: 'assets/images/pngtree-donation-illustration-png-lets-pay-zakat-ramadan-clipart-png-image_7261337.png',
      imageHeight: 280,
      imageWidth: 280,
      titleTextStyle: font(size: 30,weight: FontWeight.w700),
      subTitleTextStyle: font(size: 24,weight: FontWeight.normal),
    ),
    Introduction(
      title: 'Valantyorlik',
      subTitle:
          "Ehsonning miqdori muhim emas, balki sizning xayriyangiz ortidagi ma'no muhim",
      imageUrl: 'assets/images/pngwing.com.png',
      imageHeight: 250,
      imageWidth: 250,
      titleTextStyle: font(size: 30,weight: FontWeight.w900),
      subTitleTextStyle: font(size: 24,weight: FontWeight.normal),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: Colors.white,
      foregroundColor: Colors.blue,
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashPage(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
