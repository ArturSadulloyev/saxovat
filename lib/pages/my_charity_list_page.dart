import 'package:flutter/material.dart';

import '../models/charity_model.dart';
import '../views/font.dart';
import 'about_charity.dart';
import 'home_page.dart';

class MyCharityPage extends StatefulWidget {
  MyCharityPage({super.key});

  @override
  State<MyCharityPage> createState() => _MyCharityPageState();
}

class _MyCharityPageState extends State<MyCharityPage> {
  List<Charity> myCharity = [];

  @override
  void initState() {
    getList();
    super.initState();
  }

  void getList() {
    for (var item in allPostList) {
      if (item.userId == user?.uid) {
        myCharity.add(item);
      }
    }
    ;
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
          "Mening loyihalarim",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: GridView.builder(
        itemCount: myCharity.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: 0.9),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCharity(
                    charity: myCharity[index],
                  ),
                ),
              );
            },
            child: Card(
              child: Container(
                height: 220,
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
                        image: NetworkImage(myCharity[index].imageUrl),
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
                        myCharity[index].title,
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
                        myCharity[index].category,
                        style: font(size: 14),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        myCharity[index].location,
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
