import 'package:flutter/material.dart';
import 'package:saxovat/pages/about_charity.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/services/db_services.dart';

import '../font.dart';

class DonationView extends StatefulWidget {
  const DonationView({super.key, required this.donationList});

  final List donationList;

  @override
  State<DonationView> createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  List favoriteList = [];

  void getList() async {
    favoriteList = await user?.favoriteUserUid ?? [];
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.donationList.length,
        itemBuilder: (context, index) {
          final favoriteIcon =
              favoriteList!.contains(widget.donationList[index].id);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCharity(
                    charity: widget.donationList[index],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 1,
              child: Container(
                height: 200,
                width: 160,
                margin: const EdgeInsets.only(right: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2,right: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image:
                              NetworkImage(widget.donationList[index].imageUrl),
                          height: 100,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.donationList[index].title,
                        style: font(
                            size: 15,
                            color: Colors.black,
                            weight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            widget.donationList[index].category,
                            style: font(size: 15),
                            maxLines: 2,
                          ),
                        ),
                        /// icnBtn
                        // Container(
                        //   margin: EdgeInsets.only(right: 5),
                        //   child: Text(widget.donationList[index].createdAt),
                        //   // GestureDetector(
                        //   //   onTap: () async {
                        //   //     if (favoriteList!
                        //   //         .contains(widget.donationList[index].id)) {
                        //   //       favoriteList
                        //   //           .remove(widget.donationList[index].id);
                        //   //     } else {
                        //   //       favoriteList.add(widget.donationList[index].id);
                        //   //     }
                        //   //     DBService.updateUser(
                        //   //         user!.email,
                        //   //         user!.password,
                        //   //         user!.username,
                        //   //         user!.phoneNumber,
                        //   //         user!.name,
                        //   //         user!.userImage ?? '',
                        //   //         favoriteList ?? [],
                        //   //         user!.dateOfBirth);
                        //   //     setState(() {});
                        //   //   },
                        //   //   child: !favoriteIcon
                        //   //       ? Icon(Icons.favorite_border)
                        //   //       : Icon(Icons.favorite),
                        //   // ),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        widget.donationList[index].location,
                        style: font(
                          size: 14,
                          weight: FontWeight.w400,
                        ),
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
