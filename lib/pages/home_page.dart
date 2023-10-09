import 'package:flutter/material.dart';
import 'package:saxovat/views/font.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<AssetImage> images = [
    AssetImage(
        'assets/images/integrity-wealth-partners-blog-donor-advised-funds-.jpg'),
    AssetImage('assets/images/bg-donasi-renew.jpg'),
    AssetImage('assets/images/shutterstock_396853333-scaled.jpg'),
    AssetImage('assets/images/wheelchair.jpg'),
  ];

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
            height: 240,
            child: PageView.builder(
              padEnds: true,
              pageSnapping: true,

              itemCount: images.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(
                        image: images[index],
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 20,
                        child: Expanded(
                          child: Text(
                            "Bu yerda qandaydir manoli so'zlar bo'lishi mumkin edi Artur !",
                            style: font(
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text('Kategoriyalar'),
        ],
      ),
    );
  }
}
