import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saxovat/app.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../pages/charityPage/favourite_page.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title:  Text(
        "main",
        style: TextStyle(),
      ).tr(),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ));
          },
          icon: const Icon(
            Icons.favorite_border,
            size: 24,
            color: Colors.pinkAccent,
          ),
        ),

        PopupMenuButton<Locale>(
          onSelected: context.setLocale,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          itemBuilder: (context) {
            return const [
              PopupMenuItem(value: Locale('uz', 'UZ'), child: Text("🇺🇿 UZ")),
              PopupMenuItem(value: Locale('ru', 'RU'), child: Text("🇷🇺 RU")),
              PopupMenuItem(value: Locale('en', 'US'), child: Text("🇺🇸 EN")),
            ];
          },
          icon: const Icon(Icons.language_rounded),
        ),

      ],
      backgroundColor: Colors.transparent,
    );
  }
}
