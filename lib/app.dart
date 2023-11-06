import 'package:flutter/material.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/pages/loginPage/splash_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        initialData: null,
        stream: Auth.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return const HomePage();
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}
