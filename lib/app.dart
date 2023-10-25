import 'package:flutter/material.dart';
import 'package:saxovat/pages/add_charity_page.dart';
import 'package:saxovat/pages/contact_page.dart';
import 'package:saxovat/pages/faq_page.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/pages/login_page.dart';
import 'package:saxovat/pages/phone_auth_page.dart';
import 'package:saxovat/pages/profile_page.dart';
import 'package:saxovat/pages/select_language_page.dart';
import 'package:saxovat/pages/sign_up_page.dart';
import 'package:saxovat/pages/splash_page.dart';
import 'package:saxovat/views/home_page/category_btn.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
