import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saxovat/pages/charityPage/message_page.dart';
import 'package:saxovat/services/network.dart';
import 'package:saxovat/services/sharedPreferences.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../pages/charityPage/add_charity_page.dart';
import '../../pages/charityPage/favourite_page.dart';
import '../../pages/charityPage/my_charity_list_page.dart';
import '../../pages/home_page.dart';
import '../../pages/userPage/contact_page.dart';
import '../../pages/userPage/faq_page.dart';
import '../../pages/userPage/profile_page.dart';
import '../../services/auth_service.dart';
import '../font.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 80,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                user?.userImage == null
                    ? Icon(
                        CupertinoIcons.profile_circled,
                        size: 50,
                        color: Colors.blue.shade300,
                      )
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48), // Image radius
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: user?.userImage ??
                                  'https://w7.pngwing.com/pngs/188/501/png-transparent-computer-icons-anonymous-anonymity-anonymous-face-monochrome-head.png',
                            ),
                          ),
                        ),
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16),
                        SizedBox(width: 5),
                        Text("ordinary_user").tr(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ));
                    },
                    icon: const Icon(
                      Icons.mode_edit,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.blueAccent,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCharityPage(),
                ),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/PngItem_733744.png',
                    ),
                    height: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "charity",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ).tr(),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCharityPage(cardNumber: 'Xayriya'),
                ),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/pngegg.png',
                    ),
                    height: 35,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "donation",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ).tr()
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.blueAccent,
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.profile_circled,
              color: Colors.blue,
              size: 30,
            ),
            title:  Text(
              "personal_information",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite_border,
              size: 30,
            ),
            title: const Text(
              "saved_projects",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.my_library_books_rounded,
              color: Colors.green,
              size: 30,
            ),
            title: const Text(
              "my_projects",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCharityPage(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.question_answer_outlined,
          //     color: Colors.purple,
          //     size: 30,
          //   ),
          //   title: const Text(
          //     "Savol javoblar",
          //     style: TextStyle(fontSize: 20),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MessagePage(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.blue,
              size: 30,
            ),
            title: const Text(
              "contact_us",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.question_circle,
              color: Colors.blue,
              size: 30,
            ),
            title: const Text(
              "faq",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FaqPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              context.read<ThemeBloc>().state != ThemeMode.dark
                  ? CupertinoIcons.moon
                  : CupertinoIcons.sun_dust,
              color: Colors.blue,
              size: 30,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.read<ThemeBloc>().state != ThemeMode.dark
                      ? "night_mode"
                      : "light_mode",
                  style: TextStyle(fontSize: 18),
                ).tr(),
                Switch(
                  value: context.read<ThemeBloc>().state == ThemeMode.dark,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ThemeChanged(value));
                    ModeAndLocalization.updateDataInSharedPref(key: 'isDark', value: value);

                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FaqPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.login,
              color: Colors.red,
              size: 30,
            ),
            title: const Text(
              "exit",
              style: TextStyle(fontSize: 20),
            ).tr(),
            onTap: () async {
              await Auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
