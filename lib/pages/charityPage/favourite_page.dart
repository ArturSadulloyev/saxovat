import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';

import '../../views/font.dart';
import '../home_page.dart';
import 'about_charity.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    getList();
    super.initState();
  }

  List<Charity> favoriteList = [];

  void getList() {
    user?.favoriteUserUid.forEach((element) {
      for (var item in allPostList) {
        if (item.id == element) {
          favoriteList.add(item);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Saqlab qo'yilgan loyihalar",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: GridView.builder(
        itemCount: favoriteList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 40, childAspectRatio: 0.81),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCharity(
                    charity: favoriteList[index],
                  ),
                ),
              );
            },
            child: Card(
              child: Container(
                height: 230,
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: NetworkImage(favoriteList[index].imageUrl),
                        height: 100,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        favoriteList[index].title,
                        style: font(
                            size: 15,
                            color: Colors.black,
                            weight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 90,
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        favoriteList[index].category,
                        style: font(size: 14),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        favoriteList[index].location,
                        style: font(size: 14),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
