import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/views/font.dart';

class DonationPage extends StatelessWidget {
   DonationPage({super.key});

  final List<Charity> list =[];
  final String category ='';

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
        title: Text(category, style: font(size: 20,weight: FontWeight.w500)),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          ListTile(
            leading: Image(image: AssetImage(list[index].imageUrl[0]),),
            title: Text(list[0].location),
          );
        },
      ),
    );
  }
}
