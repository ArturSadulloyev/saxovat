import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/donation_page.dart';
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
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        title: Text(
          'Asosiy',
          style: font(
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
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
