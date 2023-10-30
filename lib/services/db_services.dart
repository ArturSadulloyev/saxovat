import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/services/auth_service.dart';

import '../models/user_model.dart';
import '../pages/home_page.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  static Future<bool> storeUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    String userImage,
    List<String> favoriteUserUid,
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

  static Future<bool> storeCharity(
    String title,
    String description,
    String userId,
    String category,
    String location,
      String? cardNumber,
      List<String> imageUrl,
  ) async{
    try {
      final folder = db.ref(Folder.post);
      final uid = folder.push().key!;
      final member = Charity(
        id: uid,
        title: title,
        description: description,
        userId: userId,
        category: category,
        location: location,
        cardNumber: cardNumber ?? '',
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
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
