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
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/user_model.dart';

final userList = [
  User(
    uid: '1',
    phoneNumber: '+998941289262',
    name: 'Sukhrob',
    email: 'Gaybullaev@gmail.com',
    userImage: 'assets/images/users/photo_2023-09-21_10-16-35.jpg',
    dateOfBirth: DateTime(1992, 04, 21), favoriteList: [], username: 'sukhrob', password: '123123',

  ),
  User(
    uid: '2',
    phoneNumber: '+998946963252',
    name: 'Alisher',
    email: 'Sadullayev@gmail.com',
    userImage: "assets/images/users/Alisher_Sa'dullayev._2022.jpg",
    dateOfBirth: DateTime(1998, 01, 14), favoriteList: [], username: 'alisher', password: '123123',

  ),
  User(
    uid: '3',
    phoneNumber: '+998941254585',
    name: 'Odilbek',
    email: 'Ibrohimov@gmail.com',
    userImage: 'assets/images/users/083A3087.JPG',
    dateOfBirth: DateTime(2002, 08, 27), favoriteList: [], username: 'odil', password: '123123',
  ),
];

final charityList = [
  Charity(
    id: '1',
    title: "Masjid tahoratxonasi uchun hissa o'z hissangizni qo'shing",
    description:
        "Assalomu aleykum Novza metrosi oldidagi masjid tahoratxonasi uchun o'z hissangizni qo'shing: Karta raqami: 8600748596696325\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Xayriya',
    location: 'Toshkent',
    cardNumber: '8600748596696325',
    imageUrl: [
      'assets/images/masjid/6991499_0_0_1279_722_2072x0_60_0_0_1cff576f6595c262373159167687f013.jpg',
      'assets/images/masjid/aoeWu_eUrAY.jpg',
      'assets/images/masjid/f98df89eb8c262c811c40ef6aeab18c4.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '2',
    title: "Yaxsilik yo'lida yordam qiling",
    description:
        "Yaxshilikni erta kechi yo'q, bugunoq yaxshilik qiling.  Karta raqami: 8600748596124781\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '2',
    category: 'Xayriya',
    location: 'Toshkent',
    cardNumber: '8600748596124781',
    imageUrl: [
      'assets/images/masjid/99.jpg',
      'assets/images/masjid/182297_best-masjid-e-nabvi-madina-saudi-arabia-7-jpg-hd-wallpapers_2560x2048_h.jpg',
      'assets/images/masjid/Mosque_Emirates_UAE_Sheikh_Zayed_Grand_Mosque_Abu_515032_2560x1708.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '3',
    title: "Vaqf fondi uchun.",
    description:
        "Vaqf fondi uchun o'z yordamingizni ayamang. Karta raqami: 8600748596412532\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '3',
    category: 'Xayriya',
    cardNumber: '8600748596412532',
    location: 'Toshkent',
    imageUrl: [
      'assets/images/masjid/4f8eedec5038bad70d16d.jpg',
      'assets/images/masjid/IhxHQgy_8_EsIYgYUznoKx3zFDXwXNF3.jpg',
      'assets/images/masjid/f98df89eb8c262c811c40ef6aeab18c4.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '2',
    title: "Mehrli qo'llar fondiga yordam !",
    description:
        "Fond uchun: Karta raqami: 8600748596412511\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Xayriya',
    location: 'Toshkent',
    cardNumber: '8600748596412511',
    imageUrl: [
      'assets/images/masjid/6ae7fda8-cd78-41ba-a072-6f04f8712bce_cover.jpg',
      'assets/images/masjid/gettyimages-168268184-1024x1024.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '2',
    title: "Nazokat opa uchun yordam",
    description:
        "Nazokat opa tuzalib ketishlari uchun 2-gruppa qon guruhi juda zarur. +998931235285\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Volontyorlik',
    location: 'Jizzax',
    imageUrl: [
      'assets/images/masjid/maxresdefault.jpg',
      'assets/images/masjid/maxresdefault (1).jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '1',
    title: "Boburjon uchun donar kerak",
    description:
        "Assalomu aleykum Boburjon uchun 3-qon gruppasidagi donar kerak. +998936965821\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Volontyorlik',
    location: 'Namangan',
    imageUrl: [
      'assets/images/masjid/maxresdefault (2).jpg',
      'assets/images/masjid/110320111066.jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '1',
    title: "Jamila opa uchun yordam",
    description:
        "Assalomu aleykum Jamila opa yurishlari uchun nogironlar aravachasiga yig'im: Karta raqami: 8600748596696325\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Volontyorlik',
    location: 'Sirdaryo',
    imageUrl: [
      'assets/images/masjid/maxresdefault (3).jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
  Charity(
    id: '3',
    title: "Lobar uchun mehr",
    description:
        "Lobar opa 2yildan buyon 1-o'zlari turadila ular uchun suhbat quradigan mehrli inson kerak(Iltimos erkaklar bezovta qilmasin). +998945658932\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    userId: '1',
    category: 'Volontyorlik',
    location: 'Vobkent',
    imageUrl: [
      'assets/images/masjid/hqdefault.jpg',
      'assets/images/masjid/maxresdefault (4).jpg',
    ],
    createdAt: DateTime.now(),
    comments: [],
  ),
];
