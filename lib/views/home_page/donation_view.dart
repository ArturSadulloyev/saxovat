import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/pages/charityPage/about_charity.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:shimmer/shimmer.dart';

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
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.donationList.length,
        itemBuilder: (context, index) {
          final favoriteIcon =
              favoriteList!.contains(widget.donationList[index].id);
          return Bounce(
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 100,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          imageUrl: widget.donationList[index].imageUrl,
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

                          margin: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'donation'.tr(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),



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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
