import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/user_model.dart';
import 'package:saxovat/services/database_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/views/font.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import 'home_page.dart';

class AboutCharity extends StatefulWidget {
  AboutCharity({super.key, required this.charity});

  Charity charity;

  @override
  State<AboutCharity> createState() => _AboutCharityState();
}

class _AboutCharityState extends State<AboutCharity> {
  bool isFavorite = false;

  // checkUser() {
  //   for (int i = 0; i < userList.length; i++) {
  //     if (userList[i].uid == widget.charity.userId) {
  //       user = userList[i];
  //       print('object');
  //       print(userList[i].favoriteList.contains(widget.charity));
  //       isFavorite = userList[i].favoriteList.contains(widget.charity);
  //       break;
  //     }
  //   }
  // }

  void _showCard(BuildContext ctx) {
    showModalBottomSheet(
      useSafeArea: true,
      barrierColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Container(
        width: 300,
        height: 250,
        color: Colors.white54,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Loyihani qo'llash",
              style: font(size: 21),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 30),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.charity.cardNumber != null
                        ? Icons.credit_card
                        : Icons.phone,
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.charity.cardNumber != null
                        ? "Karta raqami"
                        : 'Telefon raqami',
                    style: font(size: 18, weight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue.withOpacity(0.04),
              child: ListTile(
                leading: Image(
                  image: widget.charity.cardNumber != null
                      ? AssetImage('assets/images/card.png')
                      : AssetImage('assets/images/phone.png'),
                  height: 50,
                  width: 50,
                ),
                title: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.charity.cardNumber ??
                            user?.phoneNumber ??
                            '+998942223366',
                        style: font(size: 18),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                      text: widget.charity.cardNumber ??
                          user?.phoneNumber ??
                          '+998942223366',
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showQuestion(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 50,
          width: double.maxFinite,
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // // decoration: BoxDecoration(
          //     color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Xabar yozing...',
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.blue.shade900,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isFavorite = user!.favoriteUserUid.contains(widget.charity.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.95),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          'Loyiha haqida',
          style: font(
            size: 22,
            color: Colors.black,
            weight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 270,
              width: double.maxFinite,
              child: PageView.builder(
                itemCount: widget.charity.imageUrl.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      SwipeImageGallery(
                        transitionDuration: 0,
                        context: context,
                        children: [
                          Image.asset(widget.charity.imageUrl[index]),
                        ],
                      ).show();
                    },
                    child: Image(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      image: AssetImage(widget.charity.imageUrl[index]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.charity.title,
                style: font(
                  size: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(user?.userImage ?? ''),
                    ),
                  ),

                  /// network
                  // CachedNetworkImage(
                  //   imageUrl: AssetImage(user?.userImage ?? ''),
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),

                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    user?.name ?? 'No name',
                    style: font(size: 20),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      /// TODO
                      _showQuestion(context);
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade50,
                      ),
                      child: Center(
                        child: Text(
                          'Savol berish',
                          style: font(size: 18, color: Colors.blue.shade900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Badge(),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "E'lon berilgan sana",
                            style: font(size: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "21.04.2023",
                        style: font(color: Colors.blue.shade900),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Badge(),
                          const SizedBox(width: 4),
                          Text(
                            "Sanagacha to'planishi kerak",
                            style: font(size: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "23.05.2023",
                        style: font(color: Colors.blue.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Batafsil',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade900,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 6),
              child: Text(
                widget.charity.title,
                style: font(
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                widget.charity.description,
                style: font(
                  size: 16,
                  color: Colors.black87,
                  weight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          _showCard(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: Text(
                          "Loyihani qo'llash",
                          style: font(
                            size: 19,
                            color: Colors.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isFavorite!) {
                            print('add');
                            user?.favoriteUserUid?.add(widget.charity.id);
                          } else {
                            print('remove');
                            user?.favoriteUserUid?.remove(widget.charity.id);
                          }
                          isFavorite =
                              user!.favoriteUserUid.contains(widget.charity);
                          DBService.updateUserInfo();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: !isFavorite!
                            ? const Icon(
                                Icons.favorite_border,
                              )
                            : const Icon(Icons.favorite),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'Enter your reference number',
          ),
        ));
  }
}
