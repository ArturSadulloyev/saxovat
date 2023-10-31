import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/auth_service.dart';

import '../models/user_model.dart';
import '../pages/home_page.dart';
import 'database_service.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  static Future<bool> storeUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    File userImage,
    List<String> favoriteUserUid,
    String birth,
    String? uid,
  ) async {
    try {
      final folder = db.ref(Folder.user).child(uid!);

      final storage = FirebaseStorage.instance;

      ///
      final image = storage.ref(Folder.postImages).child(
          "image_${DateTime.now().toIso8601String()}${userImage?.path.substring(userImage!.path.lastIndexOf("."))}");

      final task = image.putFile(userImage);
      await task.whenComplete(() {});

      String imageUrl = await image.getDownloadURL();

      final member = User(
        uid: uid,
        username: username,
        password: password,
        phoneNumber: phoneNumber,
        name: name,
        email: email,
        userImage: imageUrl,
        favoriteUserUid: favoriteUserUid,
        dateOfBirth: birth,
      );
      await folder.set(member.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static void updateUserInfo() {
    DBService.updateUser(
        user!.email,
        user!.password,
        user!.username,
        user!.phoneNumber,
        user!.name,
        user!.userImage ?? '',
        user!.favoriteUserUid,
        user!.dateOfBirth);
  }

  static Future<bool> updateUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    String userImage,
    List favoriteList,
    String birth,
  ) async {
    //try {
    final fbUser = db.ref(Folder.user).child(Auth.auth.currentUser!.uid);
    await fbUser.update({
      "email": email,
      "password": password,
      "username": username,
      "phoneNumber": phoneNumber,
      "name": name,
      "userImage": userImage,
      "favoriteList": favoriteList,
      "birth": birth,
    });

    // fbPost.set(post.toJson());
    return true;
    // } catch (e) {
    //   debugPrint("DB ERROR: $e");
    //   return false;
    // }
  }

  static Future<User> readUserList(String uid) async {
    // try {
    var user;
    final snapshot = await db.ref(Folder.user).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final user1 = User.fromJson(value);
      if (user1.uid == uid) {
        user = user1;
        print(user.userImage);
        return user;
      }
    });
    return user;
  }

// catch (e) {
//   debugPrint("DB ERROR: $e");
//   return null;
// }
//}
  static Future<List<Charity>> readAllPost() async {
    final databaseReference = await db.ref(Folder.post);
    List<Charity> list = [];

    final child = await databaseReference.once();
    final data = child.snapshot;

    if (data.value != null) {
      final data2 = data.value as Map<dynamic, dynamic>;
      final charity = Charity.fromJson(data2);
      list.add(charity);
    }

    list.forEach((element) {
      print('Element !! ${element.title}, ${element.category}');
    });

    return list;
  }

  static Future<bool> storeCharity(
    String title,
    String description,
    String userId,
    String category,
    String location,
    String? cardNumber,
    File file,
  ) async {
    try {
      final folder = db.ref(Folder.post);
      final uid = folder.push().key!;
      final ImageUrl = await StoreService.uploadFile(file);
      print('Uidd1111111111111111111111 $uid');
      final charity = Charity(
        id: uid,
        title: title,
        description: description,
        userId: userId,
        category: category,
        location: location,
        cardNumber: cardNumber ?? '',
        imageUrl: ImageUrl,
        createdAt: DateTime.now(),
      );
      //charityList22.add(charity);

      await folder.set(charity.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }
}

sealed class StoreService {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file) async {
    List<String> list = [];
    //fileList.forEach((file) async{
    final image = storage.ref(Folder.postImages).child(
        "image_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    final task = image.putFile(file);
    await task.whenComplete(() {});
    String url = await image.getDownloadURL();
    //list.add(url);
    //});

    return url;
  }
}

sealed class Folder {
  static const post = "Post";
  static const user = "User";
  static const postImages = "PostImage";
}
