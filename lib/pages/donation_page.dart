import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/about_charity.dart';
import 'package:saxovat/views/font.dart';

import '../services/database_service.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key, required this.category});

  final String category;

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final List<Charity> list = [];

  void getList() {
    list.clear();
    for (int i = 0; i < charityList.length; i++) {
      if (charityList[i].category == widget.category) {
        list.add(charityList[i]);
      }
    }
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.category,
            style: font(size: 20, weight: FontWeight.w500)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: list.length,
        itemBuilder: (context, index) {
          File f = File(list[index].imageUrl[0]);
          if (list[index].category == widget.category) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutCharity(charity: list[index]),
                    ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image(
                      image: NetworkImage(list[index].imageUrl[0]),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                    title: Text(
                      list[0].title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(list[0].category),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
