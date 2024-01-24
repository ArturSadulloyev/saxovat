import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../pages/charityPage/about_charity.dart';
import '../../pages/home_page.dart';
import '../font.dart';

class CharityView extends StatefulWidget {
  CharityView({super.key, required this.charityList2});

  final List charityList2;

  @override
  State<CharityView> createState() => _CharityViewState();
}

class _CharityViewState extends State<CharityView> {
  List favoriteList = [];

  void getList() async {
    favoriteList = await user?.favoriteUserUid ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        //padding: const EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        itemCount: widget.charityList2.length,
        itemBuilder: (context, index) {
          final favoriteIcon =
              favoriteList!.contains(widget.charityList2[index].id);
          return Bounce(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCharity(
                    charity: widget.charityList2[index],
                  ),
                ),
              );
            },
            child: Card(
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 100,
                          width: double.maxFinite,
                          fit: BoxFit.cover, imageUrl: widget.charityList2[index].imageUrl,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.charityList2[index].title,
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
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        'charity'.tr(),
                        style: TextStyle(fontSize: 14,color: Colors.black),

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        widget.charityList2[index].location,
                        style: font(size: 14),


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
