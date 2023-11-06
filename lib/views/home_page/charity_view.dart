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
      height: 220,
      child: ListView.builder(
        //padding: const EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        itemCount: widget.charityList2.length,
        itemBuilder: (context, index) {
          final favoriteIcon =
              favoriteList!.contains(widget.charityList2[index].id);
          return GestureDetector(
            onTap: () {
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2, right: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image:
                              NetworkImage(widget.charityList2[index].imageUrl),
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
                      width: 90,
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        widget.charityList2[index].category,
                        style: font(size: 14),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Text(
                        widget.charityList2[index].location,
                        style: font(size: 14),
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
