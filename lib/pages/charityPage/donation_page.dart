import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/pages/charityPage/about_charity.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/views/font.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key, required this.category});

  final String category;

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  List<Charity> list = [];
  List<Charity> list2 = [];
  List<Charity> searchResults = [];

  void getList() {
    list.clear();
    list2.clear();
    for (int i = 0; i < allPostList.length; i++) {
      if (allPostList[i].category == widget.category) {
        print(allPostList[i].imageUrl);
        list.add(allPostList[i]);
        list2.add(allPostList[i]);
      }
    }
  }

  void onSearchTextChanged(String searchText) {
    searchResults.clear();

    if (searchText.isEmpty) {
      getList();

      setState(() {});
      return;
    }

    list2.forEach((item) {
      if (item.title.toLowerCase().contains(searchText.toLowerCase())) {
        searchResults.add(item);
      }
    });

    if ((searchResults.isEmpty && searchText.isNotEmpty)) {
      list = searchResults;
    }

    if (searchText.isNotEmpty) {
      list = searchResults;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            // color: Colors.black,
            size: 20,
          ),
        ),
        elevation: 1,
        // backgroundColor: Colors.white,
        title: Text(widget.category,
            style: font(size: 20, weight: FontWeight.w500, color: Colors.red)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.35)),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.grey.withOpacity(0.35),
                  //   spreadRadius: 2,
                  //   blurRadius: 5,
                  //   offset: Offset(0, 2),
                  // ),
                ],
              ),
              child: TextField(
                onChanged: onSearchTextChanged,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: 'search'.tr(),
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(4),
              itemCount: list.length,
              itemBuilder: (context, index) {
                File f = File(list[index].imageUrl[0]);
                if (list[index].category == widget.category) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AboutCharity(charity: list[index]),
                          ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        height: 240,
                        width: 150,
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: list[index].imageUrl,
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
                                list[index].title,
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
                                list[index].category,
                                style: TextStyle(fontSize: 14,color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 5),
                              child: Text(
                                list[index].location,
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
                }
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.79),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
