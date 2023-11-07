import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'db_services.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  static Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    File userImage,
    List<String> favoriteUserUid,
    String birth,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);

        await DBService.storeUser(email, password, username, phoneNumber, name,
            userImage, favoriteUserUid, birth, credential.user!.uid);
      }

      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}
