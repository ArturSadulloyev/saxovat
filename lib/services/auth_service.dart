import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart';

import 'db_services.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;


  Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<bool> createUserWithEmailAndPassword(
      String email, String password,String username) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);

        // await DBService.storeUser(
        //     email, password, username, credential.user!.uid);
      }

      return credential.user != null;
    } catch (e) {
      debugPrint("ERROR: $e");
      return false;
    }
  }

  static Future<void> signInWithPhoneNumber(String phoneNumber) async {
    await _auth.signInWithPhoneNumber(
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
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
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
        await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
