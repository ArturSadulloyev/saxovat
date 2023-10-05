import 'package:flutter/material.dart';
import 'package:saxovat/views/font.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Asosiy',
          style: font(
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              primary: false,
              children: [
                for (int i = 0; i < 8; i++)
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Image(
                            width: 390,
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/images/integrity-wealth-partners-blog-donor-advised-funds-.jpg'))),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
