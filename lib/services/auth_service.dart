import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../models/charity_model.dart';
import 'db_services.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  static Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
    final credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }

  static Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phoneNumber,
    String name,
    String userImage,
    List<Charity> favoriteList,
    String birth,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);

        await DBService.storeUser(email, password, username,
            phoneNumber, name, userImage, favoriteList, birth,credential.user!.uid);
      }

      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }




  static Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await auth.signInWithPhoneNumber(
      phoneNumber,
      // RecaptchaVerifier(
      //   container: "recaptcha",
      //   size: RecaptchaVerifierSize.compact,
      //   theme: RecaptchaVerifierTheme.dark,
      //   onSuccess: () => print('reCAPTCHA Completed!'),
      //   onError: (FirebaseAuthException error) => print(error),
      //   onExpired: () => print('reCAPTCHA Expired!'),
      //   auth: FirebaseAuthPlatform.instance,
      // ),
    );
  }

  static Future<void> verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}
