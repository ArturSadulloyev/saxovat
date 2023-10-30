import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/database_service.dart';

import 'home_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    getList();
    super.initState();
  }

  List<Charity> favoriteList = [];

  void getList() {
    print(user?.favoriteUserUid.length);
    user?.favoriteUserUid.forEach((element) {
      for (var item in charityList) {
        if (item.id == element) {
          favoriteList.add(item);
          print(element);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: favoriteList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteList[index].title)
          );
        },
      ),
    );
  }
}
