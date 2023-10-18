// import 'package:firebase_auth/firebase_auth.dart';
//
// class Db {
//   static Future<void> verifyPhoneNumber() async {
//     final result = await FirebaseAuth.instance.verifyPhoneNumber(
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/user_model.dart';

final userList = [
  User(
    uid: '1',
    phoneNumber: '+998941289262',
    name: 'Sukhrob',
    surname: 'Gaybullaev',
    userImage: '',
  ),
];

final charityList = [
  Charity(
    id: '1',
    title: "Masjid tahoratxonasi uchun hissa o'z hissangizni qo'shing",
    description:
        "Assalomu aleykum Novza metrosi oldidagi masjid tahoratxonasi uchun o'z hissangizni qo'shing: Karta raqami: 8600748596696325",
    userId: '1',
    category: 'Xayriya',
    location: 'Toshkent',
    imageUrl: [
      'assets/images/masjid/6991499_0_0_1279_722_2072x0_60_0_0_1cff576f6595c262373159167687f013.jpg',
      'assets/images/masjid/aoeWu_eUrAY.jpg',
      'assets/images/masjid/f98df89eb8c262c811c40ef6aeab18c4.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
];
