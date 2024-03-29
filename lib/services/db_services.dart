import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:saxovat/models/charity_model.dart';
import 'package:saxovat/models/message_model.dart';
import 'package:saxovat/pages/home_page.dart';
import 'package:saxovat/services/auth_service.dart';
import 'package:saxovat/services/network.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';

sealed class DBService {
  static final db = FirebaseDatabase.instance;

  /// user

  /// create
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

  /// read
  static Future<User?> readUserList(String uid) async {
    User? user;

    final snapshot = await Network.methodGet(api: Network.apiUsers);
    final map = Network.parseUserList(snapshot!);
    print('Uid ::: ${uid}');
    map.forEach((element) {
      if (element.uid == uid) {
        user = element;
      }
    });

    return user;
  }

  static Future<List<User>> readUserAllList() async {
    final snapshot = await Network.methodGet(api: Network.apiUsers);
    final map = await Network.parseUserList(snapshot!);

    return map;
  }

  /// update
  static Future<bool> updateUser(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    File userImage,
    List favoriteList,
    String birth,
  ) async {
    var map = ({
      "email": email,
      "password": password,
      "username": username,
      "phoneNumber": phoneNumber,
      "name": name,
      // "userImage": imgUrl,
      "favoriteList": favoriteList,
      "birth": birth,
    });
    await Network.methodPut(api: Network.apiUsers, id: user!.uid, data: map);

    return true;
  }

  /// read all user
  static Future<List> readAllUserList() async {
    final list = [];
    final snapshot = await db.ref(Folder.user).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final user1 = User.fromJson(value);
      list.add(user1);
    });
    return list;
  }

  /// CHARITY

  /// create
  static Future<bool> storeCharity(
    String id,
    String title,
    String description,
    String userId,
    String category,
    String location,
    String? cardNumber,
    String charityId,
    File file,
  ) async {
    try {
      final folder = db.ref(Folder.post);

      final child = folder.child(id);
      final ImageUrl = await StoreService.uploadFile(file);
      Charity charity = Charity(
        id: id,
        title: title,
        description: description,
        userId: userId,
        charityId: charityId,
        category: category,
        location: location,
        cardNumber: cardNumber ?? '',
        imageUrl: ImageUrl,
        createdAt:
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
      );
      await child.set(charity.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  /// read
  static Future<List<Charity>> readAllPost() async {
    final databaseReference = await db.ref(Folder.post).get();
    List<Charity> list = [];

    final map = databaseReference.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      final charity = Charity.fromJson(value);
      list.add(charity);
    });
    return list;
  }

  /// update
  static Future<bool> updateCharity(
    String postId,
    String title,
    String content,
    String category,
    String location,
    String cardNumber,
    File imageUrl,
  ) async {
    final fbUser = db.ref(Folder.post).child(postId);
    //String img = await StoreService.uploadFile(imageUrl);
    await fbUser.update({
      "title": title,
      "content": content,
      "category": category,
      "location": location,
      "cardNumber": cardNumber,
    });
    return true;
  }

  /// delete
  static Future<bool> deleteCharity(String uid) async {
    try {
      await db.ref(Folder.post).child(uid).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Message

  /// create
  static Future<bool> storeMessage(
    String message,
    String recipientId,
    String charityId,
  ) async {
    try {
      final folder = db.ref(Folder.message);
      final id = Uuid().v4();
      final child = folder.child(id);

      Message message1 = Message(
        id: charityId,
        message: message,
        writtenAt: DateTime.now().toString(),
        recipientId: recipientId,
        senderId: user!.uid,
      );

      await child.set(message1.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  /// read
  static Future<List<Message>> readAllMessage(String uid) async {
    final databaseReference = await db.ref(Folder.message).get();
    List<Message> list = [];

    final map = databaseReference.value as Map<dynamic, dynamic>;
    print(databaseReference.value);
    map.forEach((key, value) {
      final msg = Message.fromJson(value);
      if (msg.recipientId == uid) {
        list.add(msg);
      }
    });

    list.forEach((element) {
      print('MSg: ${element.message}');
    });
    return list;
  }

  /// store with panel
  static Future<bool> storeCharityPanel(String charityId, bool approve) async {
    try {
      final folder = db.ref(Folder.mainPost);
      final id = const Uuid().v4();
      final child = folder.child(charityId);
      MainCharity mainCharity =
          MainCharity(id: charityId, charityId: charityId, approve: false);
      await child.set(mainCharity.toJson());
      return true;
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return false;
    }
  }

  /// read Post api
  static Future<List<Charity>> readPost() async {
    final data = await Network.methodGet(api: Network.apiCharity);
    final data2 = await Network.methodGet(api: Network.apiMainCharity);

    final list = await Network.parseCharityList(data!);
    final list2 = await Network.parseMainCharityList(data2!);

    Set<Charity> listMain = {};



    list2.forEach((element) {
      list.forEach((element2) {
        if (element.charityId == element2.charityId) {
          if (element.approve) {
            listMain.add(element2);
          }
        }
      });
    });

    print(listMain.length);




    return listMain.toList();
  }
}

sealed class StoreService {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file) async {
    final image = storage.ref(Folder.postImages).child(
        "image_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    final task = image.putFile(file);
    await task.whenComplete(() {});
    String url = await image.getDownloadURL();
    return url;
  }

  static Future<String> updateFile(File file) async {
    final image = storage.ref(Folder.postImages).child(
        "image_${DateTime.now().toIso8601String()}${file.path.substring(file.path.lastIndexOf("."))}");
    //final task = image.putFile(file);
    //await task.whenComplete(() {});
    String url = await image.getDownloadURL();
    return url;
  }
}

sealed class Folder {
  static const post = "Post";
  static const mainPost = "MainPost";
  static const user = "User";
  static const postImages = "PostImage";
  static const message = "Message";
}
