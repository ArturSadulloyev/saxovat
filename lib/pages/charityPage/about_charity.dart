import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/user_model.dart';
import 'package:saxovat/pages/charityPage/delete_edit_charity_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/db_services.dart';
import 'package:saxovat/services/network.dart';
import 'package:saxovat/views/font.dart';
import 'package:saxovat/views/no_internet_page.dart';
import 'package:http/http.dart' as http;
import '../home_page.dart';

class AboutCharity extends StatefulWidget {
  AboutCharity({super.key, required this.charity});

  Charity charity;

  @override
  State<AboutCharity> createState() => _AboutCharityState();
}

class _AboutCharityState extends State<AboutCharity> {
  bool isFavorite = false;
  List<User> userMain2 = [];
  var userMain;

  TextEditingController msgController = TextEditingController();
  bool isInternetConnected = true;

  void _isFavorite() {
    if (user!.favoriteUserUid.contains(widget.charity.id)) {
      user?.favoriteUserUid!.remove(widget.charity.id);
    } else {
      user?.favoriteUserUid!.add(widget.charity.id);
    }
    isFavorite = user!.favoriteUserUid.contains(widget.charity.id!);
    final file = File(user!.userImage ?? '');
    DBService.updateUser(
      user!.email,
      user!.password,
      user!.username,
      user!.phoneNumber,
      user!.name,
      file,
      user!.favoriteUserUid ?? [],
      user!.dateOfBirth,
    );
    setState(() {});
  }

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
                    widget.charity.cardNumber?.length != 0
                        ? Icons.credit_card
                        : Icons.phone,
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.charity.cardNumber?.length != 0
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
                  image: widget.charity.cardNumber?.length != 0
                      ? AssetImage('assets/images/card.png')
                      : AssetImage('assets/images/phone.png'),
                  height: 50,
                  width: 50,
                ),
                title: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.charity.cardNumber?.length == 0
                            ? user?.phoneNumber
                            : widget.charity.cardNumber,
                        style: font(size: 18, color: Colors.black),
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: msgController,
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
                  DBService.storeMessage(
                    msgController.text,
                    widget.charity.userId,
                    widget.charity.id,
                  );
                  msgController.text = '';
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

  Future<void> checkInternetConnection() async {
    try {
      Uri url = Uri.https('google.com');
      final response = await http.get(url);
      setState(() {
        isInternetConnected = response.statusCode == 200;
      });
    } catch (e) {
      setState(() {
        isInternetConnected = false;
      });
    }
  }

  Future<bool> checkInternetConnection2() async {
    try {
      Uri url = Uri.https('google.com');
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  bool isLoading = false;
  bool checkInternet = true;

  void findUser() async {
    setState(() {
      isLoading = true;
    });
    userMain2 = await DBService.readUserAllList();

    userMain2.forEach((element) {
      if (element.uid == widget.charity.userId) {
        userMain = element;
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    findUser();
    checkInternetConnection();
    super.initState();
    isFavorite = user!.favoriteUserUid.contains(widget.charity.id);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        findUser();
        checkInternetConnection();
      },
      child: Stack(
        children: [
          Scaffold(
            // backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              // backgroundColor: Colors.white.withOpacity(0.95),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  // color: Colors.black,
                ),
              ),
              elevation: 0,
              title: Text(
                'about_project'.tr(),
                style: font(
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
              ),
              actions: [
                widget.charity.userId == user?.uid
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteEditCharityPage(
                                charity: widget.charity,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          // color: Colors.black,
                        ),
                      )
                    : SizedBox.shrink(),
                widget.charity.userId == user?.uid
                    ? IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          isInternetConnected =
                              await checkInternetConnection2();

                          if (isInternetConnected) {
                            final res = await Network.methodDelete(
                              api: Network.apiCharity,
                              id: widget.charity.id,
                            );
                            final res2 = await Network.methodDelete(
                              api: Network.apiMainCharity,
                              id: widget.charity.id,
                            );
                            if (res) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Loyihangiz o'chirildi !"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Xatolik yuz berdi !"),
                                ),
                              );
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          // color: Colors.black,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 270,
                    width: double.maxFinite,
                    child: PageView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showImageViewer(
                                context,
                                doubleTapZoomable: true,
                                Image.network(widget.charity.imageUrl).image);
                            // SwipeImageGallery(
                            //   transitionDuration: 0,
                            //   context: context,
                            //   children: [
                            //     Image(image: NetworkImage(widget.charity.imageUrl)),
                            //   ],
                            // ).show();
                          },
                          child: CachedNetworkImage(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            imageUrl: widget.charity.imageUrl,
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
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: userMain?.userImage ??
                                    'https://w7.pngwing.com/pngs/188/501/png-transparent-computer-icons-anonymous-anonymity-anonymous-face-monochrome-head.png',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          width: 155,
                          child: Text(
                            userMain?.name ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Spacer(),
                        widget.charity.userId != user!.uid
                            ? GestureDetector(
                                onTap: () {
                                  /// TODO
                                  _showQuestion(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // color: Colors.blue.shade50,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'question'.tr(),
                                      style: font(
                                          size: 18,
                                          color: Colors.blue.shade900),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
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
                                  "date_of_publication".tr(),
                                  style: font(size: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.charity.createdAt.substring(0, 10) ??
                                  '11.04.2023',
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
                      'information'.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        // color: Colors.blue.shade900,
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
                                "application_of_the_project".tr(),
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
                                _isFavorite();
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
                                color: Colors.pinkAccent,
                                    )
                                  : const Icon(Icons.favorite,color: Colors.pinkAccent,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60)
                ],
              ),
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator.adaptive()),
          if (!isInternetConnected)
            RefreshIndicator(
              onRefresh: () async {
                findUser();
                checkInternetConnection();
              },
              child: NoInternetPage(
                function: findUser,
                function1: checkInternetConnection,
                ctx: context,
              ),
            ),
        ],
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
