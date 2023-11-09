import 'package:flutter/material.dart';

import '../../pages/charityPage/favourite_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Asosiy",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ));
          },
          icon: Icon(
            Icons.favorite_border,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
