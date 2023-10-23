import 'package:flutter/material.dart';
import 'package:saxovat/pages/about_charity.dart';

import '../font.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key, required this.donationList});

  final List donationList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: donationList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCharity(
                    charity: donationList[index],
                  ),
                ),
              );

            },
            child: Card(
              elevation: 1,
              child: Container(
                height: 200,
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage(donationList[index].imageUrl[0]),
                        height: 100,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        donationList[index].title,
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
                        donationList[index].category,
                        style: font(size: 15),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        donationList[index].location,
                        style: font(size: 14, weight: FontWeight.w400),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
