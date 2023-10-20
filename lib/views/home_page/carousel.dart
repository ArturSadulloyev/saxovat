import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  Carousel({super.key});
  final List<AssetImage> images = [
    const AssetImage(
        'assets/images/integrity-wealth-partners-blog-donor-advised-funds-.jpg'),
    const AssetImage('assets/images/bg-donasi-renew.jpg'),
    const AssetImage('assets/images/shutterstock_396853333-scaled.jpg'),
    const AssetImage('assets/images/wheelchair.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
