import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxovat/pages/charityPage/message_page.dart';

import '../../pages/charityPage/add_charity_page.dart';
import '../../pages/charityPage/favourite_page.dart';
import '../../pages/charityPage/my_charity_list_page.dart';
import '../../pages/home_page.dart';
import '../../pages/userPage/contact_page.dart';
import '../../pages/userPage/faq_page.dart';
import '../../pages/userPage/profile_page.dart';
import '../../services/auth_service.dart';
import '../font.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.black,
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
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user!.userImage ?? ''),
                        ),
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16),
                        SizedBox(width: 5),
                        Text("Oddiy foydalanuvchi"),
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
                    "Hashar",
                    style: font(
                        color: Colors.blue.shade900, weight: FontWeight.w800),
                  )
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
                    "Xayriya",
                    style: font(
                        color: Colors.blue.shade900, weight: FontWeight.w800),
                  )
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
            title: const Text(
              "Shaxsiy ma'lumotlar",
              style: TextStyle(fontSize: 20),
            ),
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
              color: Colors.black,
              size: 30,
            ),
            title: const Text(
              "Saqlangan loyihalar",
              style: TextStyle(fontSize: 20),
            ),
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
              "Mening loyihalarim",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCharityPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.question_answer_outlined,
              color: Colors.purple,
              size: 30,
            ),
            title: const Text(
              "Savol javoblar",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.blue,
              size: 30,
            ),
            title: const Text(
              "Biz bilan aloqa",
              style: TextStyle(fontSize: 20),
            ),
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
              "FAQ",
              style: TextStyle(fontSize: 20),
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
              "Chiqish",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () async {
              await Auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
