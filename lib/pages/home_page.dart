import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/donation_page.dart';
import 'package:saxovat/pages/faq_page.dart';
import 'package:saxovat/pages/select_language_page.dart';
import 'package:saxovat/services/database_service.dart';
import 'package:saxovat/views/font.dart';
import 'package:saxovat/views/home_page/carousel.dart';
import 'package:saxovat/views/home_page/category_btn.dart';
import 'package:saxovat/views/home_page/charity_view.dart';
import 'package:saxovat/views/home_page/donation_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Charity> donationList = [];
  final List<Charity> charityList2 = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < charityList.length; i++) {
      if (charityList[i].category == 'Xayriya') {
        donationList.add(charityList[i]);
      } else {
        charityList2.add(charityList[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Asosiy",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
                  Icon(
                    CupertinoIcons.profile_circled,
                    size: 50,
                    color: Colors.blue.shade300,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Suxrob",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("Oddiy foydalanuvchi"),
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
            ListTile(
              leading: const Icon(
                CupertinoIcons.question_circle,
                color: Colors.blue,
              ),
              title: const Text("FAQ"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FaqPage(),
                  ),
                );
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
              Carousel(),
              Text('Kategoriyalar', style: font(size: 20)),
              const SizedBox(height: 20),
              const CategorySelectBtn(),
              const SizedBox(height: 20),
              Text('Xayriya', style: font(size: 20)),
              const SizedBox(height: 20),
              DonationView(donationList: donationList),
              const SizedBox(height: 20),
              Text('Volontyorlik', style: font(size: 20)),
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
