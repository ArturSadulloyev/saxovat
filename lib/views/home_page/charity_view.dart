import 'package:flutter/material.dart';

import '../font.dart';

class CharityView extends StatelessWidget {
  const CharityView({super.key,required this.charityList2});
  final List charityList2;
  @override
  Widget build(BuildContext context) {
    return            SizedBox(
      height: 220,
      child: ListView.builder(
        //padding: const EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        itemCount: charityList2.length,
        itemBuilder: (context, index) {
//                    if (charityList[index].category == 'Volontyorlik') {}
          return Container(
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
                    image:
                    AssetImage(charityList2[index].imageUrl[0]),
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
                    charityList2[index].title,
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
                  width: 90,
                  margin: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    charityList2[index].category,
                    style: font(size: 14),
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Text(
                    charityList2[index].location,
                    style: font(size: 14),
                    maxLines: 2,
                  ),
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
          );
        },
      ),
    );
  }
}
