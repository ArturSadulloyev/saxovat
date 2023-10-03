import 'package:flutter/material.dart';
import 'package:saxovat/pages/about_project_page.dart';
import 'package:saxovat/pages/select_language_page.dart';
import 'package:saxovat/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('suxrob object');
<<<<<<<<< Temporary merge branch 1
    return const MaterialApp(
=========
    return  MaterialApp(
>>>>>>>>> Temporary merge branch 2
      debugShowCheckedModeBanner: false,
      home: AboutProjectPage(),
    );
  }
}
