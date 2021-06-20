import 'package:baztami_app_flutter/screens/login.dart';
import 'package:baztami_app_flutter/screens/nav_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return NaVBottomBar();
          } else {
            return LoginPage();
          }
        });
  }

  //Sign out
  signOut() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  //SignIn
  Future<int> signIn(AuthCredential authCreds) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
      createUserCollection(
          userCredential.user!.uid, userCredential.user!.phoneNumber);
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        print('The OTP CODE IS INVALID');
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

//sign in when message  code arrive
  Future<int> signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    var i = await signIn(authCreds);
    return i;
  }

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  Future createUserCollection(String uid, String? phoneNumber) async {
    return await userCollection.doc(uid).set({
      "phoneNumber": phoneNumber,
    });
  }
}
