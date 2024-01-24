import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saxovat/bloc/theme/theme.dart';
import 'package:saxovat/bloc/theme/theme_bloc.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/pages/loginPage/splash_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bloc/auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordVisibilityBloc>(
            create: (_) => PasswordVisibilityBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
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
        },
      ),
    );
  }
}
