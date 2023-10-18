import 'package:flutter/material.dart';
import 'package:saxovat/services/database_service.dart';
import 'package:saxovat/views/font.dart';

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
              SizedBox(
                height: 240,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(10),
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
                          // Text(
                          //   "Bu yerda qandaydir manoli so'zlar bo'lishi mumkin edi Artur !",
                          //   style: font(
                          //     size: 18,
                          //     color: Colors.white,
                          //   ),
                          //  ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text('Kategoriyalar', style: font(size: 20)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.green.shade50,
                        elevation: 0,
                        onPressed: () {},
                        child: const Image(
                          height: 40,
                          width: 40,
                          image: AssetImage('assets/images/PngItem_733744.png'),
                        ),
                      ),
                      const Text('Volontyorlik'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.blue.shade50,
                        elevation: 0,
                        onPressed: () {},
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage('assets/images/pngegg.png'),
                        ),
                      ),
                      Text('Xayriya'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Xayriya', style: font(size: 20)),
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  //padding: const EdgeInsets.all(20),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder:(context, index) =>  Container(
                    height: 200,
                    width: 150,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(charityList[0].imageUrl[0]),
                          height: 100,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            charityList[0].title,
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
                          width: 70,
                          margin: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            charityList[0].category,
                            style: font(size: 15),
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          charityList[0].location,
                          style: font(size: 14),
                          maxLines: 2,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       charityList[0].createdAt.day.toString().padLeft(2, "0"),
                        //       style: font(size: 12),
                        //       maxLines: 2,
                        //     ),
                        //     Text(
                        //       charityList[0]
                        //           .createdAt
                        //           .month
                        //           .toString()
                        //           .padLeft(2, "0"),
                        //       style: font(size: 12),
                        //       maxLines: 2,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text('Volontyorlik', style: font(size: 20)),
              const SizedBox(height: 20),

              SizedBox(
                height: 220,
                child: ListView.builder(
                  //padding: const EdgeInsets.all(20),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder:(context, index) =>  Container(
                    height: 200,
                    width: 150,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(charityList[0].imageUrl[0]),
                          height: 100,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            charityList[0].title,
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
                          width: 70,
                          margin: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            charityList[0].category,
                            style: font(size: 15),
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          charityList[0].location,
                          style: font(size: 14),
                          maxLines: 2,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       charityList[0].createdAt.day.toString().padLeft(2, "0"),
                        //       style: font(size: 12),
                        //       maxLines: 2,
                        //     ),
                        //     Text(
                        //       charityList[0]
                        //           .createdAt
                        //           .month
                        //           .toString()
                        //           .padLeft(2, "0"),
                        //       style: font(size: 12),
                        //       maxLines: 2,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
