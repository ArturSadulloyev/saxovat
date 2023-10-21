import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
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

  @override
  void initState() {
    super.initState();
    list.clear();
    for (int i = 0; i < charityList.length; i++) {
      if (charityList[i].category == widget.category) {
        list.add(charityList[i]);
      }
    }
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
        backgroundColor: Colors.transparent,
        title: Text(widget.category,
            style: font(size: 20, weight: FontWeight.w500)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].category == widget.category) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image(

                  height: 350,
                  width: 150,
                  fit: BoxFit.cover,
                  image: AssetImage(list[index].imageUrl[0]),
                ),
                title: Text(
                  list[0].title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(list[0].category),
              ),
            );
          }
        },
      ),
    );
  }
}
