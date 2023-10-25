import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';

import '../models/user_model.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  static Future<bool> storeUser(
      String email,
      String password,
      String username,
      String uid,
      String phoneNumber,
      String name,
      String userImage,
      List<Charity> favoriteList,
      DateTime birth) async {
    try {
      final folder = db.ref(Folder.user).child(uid);
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
}

sealed class Folder {
  static const post = "Post";
  static const user = "User";
  static const postImages = "PostImage";
}
