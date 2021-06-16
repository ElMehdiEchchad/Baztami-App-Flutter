import 'package:baztami_app_flutter/screens/login.dart';
import 'package:baztami_app_flutter/screens/nav_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  signIn(AuthCredential authCreds) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
      return 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        print('The OTP CODE IS INVALID');
      }
    } catch (e) {
      print(e);
    }
  }

//sign in when message  code arrive
  signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    var i = await signIn(authCreds);
    return i;
  }
}
