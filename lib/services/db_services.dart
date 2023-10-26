import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/auth_service.dart';

import '../models/user_model.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  static Future<bool> storeUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    String userImage,
    List<Charity> favoriteList,
    String birth,
    String? uid,
  ) async {
    try {
      final folder = db.ref(Folder.user).child(uid!);
      final member = User(
        uid: uid,
        username: username,
        password: password,
        phoneNumber: phoneNumber,
        name: name,
        email: email,
        userImage: userImage,
        favoriteList: favoriteList,
        dateOfBirth: birth,
      );
      await folder.set(member.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  static Future<bool> updateUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    String userImage,
    List<Charity> favoriteList,
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
}

sealed class Folder {
  static const post = "Post";
  static const user = "User";
  static const postImages = "PostImage";
}
