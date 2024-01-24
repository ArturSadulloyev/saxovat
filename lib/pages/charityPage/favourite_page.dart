import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:http/http.dart' as http;
import '../../views/font.dart';
import '../home_page.dart';
import 'about_charity.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isInternetConnected = true;

  @override
  void initState() {
    checkInternetConnection();

    getList();

    super.initState();
  }

  Future<void> checkInternetConnection() async {
    try {
      Uri  url = Uri.https('google.com');
      final response = await http.get(url);
      setState(() {
        isInternetConnected = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        isInternetConnected = false;
      });
    }
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
        // iconTheme: const IconThemeData(color: Colors.black),
        // backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "saved_projects",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
        ).tr(),
      ),
      body: Stack(
        children: [
          GridView.builder(
            itemCount: favoriteList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 0, childAspectRatio: 0.73),
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
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    height: 230,
                    width: 150,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: favoriteList[index].imageUrl,
                            height: 120,
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
                            style: TextStyle(fontSize: 14,color: Colors.black),
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
          if (!isInternetConnected)
            Center(
              child: Text('No Enthernet'),
            )
        ],
      ),
    );
  }
}
