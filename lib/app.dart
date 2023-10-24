import 'package:flutter/material.dart';
import 'package:saxovat/pages/about_project_page.dart';
import 'package:saxovat/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
