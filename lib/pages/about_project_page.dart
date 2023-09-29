import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:saxovat/pages/sign_in_page.dart';
import 'package:saxovat/views/font.dart';

class AboutProjectPage extends StatelessWidget {
  AboutProjectPage({Key? key}) : super(key: key);
  final List<Introduction> list = [
    Introduction(
      title: 'Ehson',
      subTitle:
          "Hayriya so'ngan qalblarni porlatishi, qurigan daraxtlarni yashnatishi mumkin",
      imageUrl: 'assets/images/SeekPng.com_gold-medal-png_1656979.png',
      imageHeight: 250,
      imageWidth: 250,
      titleTextStyle: font(size: 24),
      subTitleTextStyle: font(size: 24),
    ),
    Introduction(
      title: 'Valantyorlik',
      subTitle:
          "Ehsonning miqdori muhim emas, balki sizning xayriyangiz ortidagi ma'no muhim",
      imageUrl: 'assets/images/pngwing.com.png',
      imageHeight: 250,
      imageWidth: 250,
      titleTextStyle: font(size: 24),
      subTitleTextStyle: font(size: 24),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
