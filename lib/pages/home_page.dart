import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/contact_page.dart';
import 'package:saxovat/pages/faq_page.dart';
import 'package:saxovat/pages/favourite_page.dart';
import 'package:saxovat/pages/profile_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/database_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';
import 'package:saxovat/views/home_page/carousel.dart';
import 'package:saxovat/views/home_page/category_btn.dart';
import 'package:saxovat/views/home_page/charity_view.dart';
import 'package:saxovat/views/home_page/donation_view.dart';
import '../models/user_model.dart';
import 'add_charity_page.dart';
import 'donation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

User? user;

class _HomePageState extends State<HomePage> {
  final List<Charity> donationList = [];
  final List<Charity> charityList2 = [];
  void getList() async {
    user = await DBService.readUserList(Auth.auth.currentUser!.uid);

    final allPostList = await DBService.readAllPost();
    allPostList.forEach((element) {
      print(element.title);
    });
    for (int i = 0; i < allPostList.length; i++) {
      if (allPostList[i].category == 'Xayriya') {
        donationList.add(allPostList[i]);
      } else {
        charityList2.add(allPostList[i]);
      }
    }
    print(user!.name ?? 'No name');
  }

  @override
  void didChangeDependencies() {
    getList();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
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
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.black,
        child: ListView(
          children: [
            SizedBox(
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  user?.userImage == null
                      ? Icon(
                          CupertinoIcons.profile_circled,
                          size: 50,
                          color: Colors.blue.shade300,
                        )
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user!.userImage ?? ''),
                          ),
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.person, size: 16),
                          SizedBox(width: 5),
                          Text("Oddiy foydalanuvchi"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: IconButton(
                      splashRadius: 1,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mode_edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.blueAccent,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCharityPage(),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/PngItem_733744.png',
                      ),
                      height: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Volontyor bo'ling",
                      style: font(
                          color: Colors.blue.shade900, weight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCharityPage(cardNumber: 'Xayriya'),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/pngegg.png',
                      ),
                      height: 35,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Xayriya",
                      style: font(
                          color: Colors.blue.shade900, weight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.profile_circled,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Shaxsiy ma'lumotlar",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Biz bilan aloqa",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.question_circle,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "FAQ",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FaqPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.login,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Chiqish",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                await Auth.signOut();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              CarouselCard(),
              Text('Kategoriyalar', style: font(size: 20)),
              const SizedBox(height: 20),
              const CategorySelectBtn(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Xayriya', style: font(size: 20)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DonationPage(
                            category: 'Xayriya',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Barchasi',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DonationView(donationList: donationList),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Volontyorlik', style: font(size: 20)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DonationPage(
                            category: 'Volontyorlik',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Barchasi',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CharityView(charityList2: charityList2),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
