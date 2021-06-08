import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'nav_bottom_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: _uildWelcomeImage()),
              Flexible(child: InternationalPhoneInput()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _uildWelcomeImage() {
  return Container(
    child: Image.asset("assets/images/welcome_page_illustration.png"),
  );
}

class InternationalPhoneInput extends StatefulWidget {
  @override
  _InternationalPhoneInputState createState() =>
      _InternationalPhoneInputState();
}

class _InternationalPhoneInputState extends State<InternationalPhoneInput> {
  PhoneNumber phoneNumber = PhoneNumber();
  String verificationId = "";
  bool codeSent = false;
  String smsCode = "";

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Center(
              child: InternationalPhoneNumberInput(
                hintText: "Enter votre num...",
                onInputChanged: (PhoneNumber value) => _handleInput(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Entrer votre numero de telphone en cas de perte changement de telephone vous pourriez acceder à votre compte par votre numero de telephone",
                style: TextStyle(
                  color: Palette.grey1Color,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ]),
          codeSent
              ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  ))
              : Container(),
          ElevatedButton(
            onPressed: () {
              _handleLogin();
            },
            child: Text(
              "GO",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Palette.backgroundColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width - 60, 50),
              side: BorderSide(width: 2.0, color: Palette.primaryLightColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              primary: Palette.primaryLightColor,
            ),
          ),
        ],
      ),
    );
  }

  _handleLogin() {
    if (phoneNumber.dialCode.toString().length <
        phoneNumber.phoneNumber.toString().length) {
      //check number in firebase
      codeSent
          ? AuthService().signInWithOTP(smsCode, verificationId)
          : verifyPhone(phoneNumber);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => NaVBottomBar()),
      // );
    }
  }

  Future<void> verifyPhone(PhoneNumber phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      //sign in with credentiels
      AuthService().signIn(authResult);
    };

    //this for handle the error message
    final PhoneVerificationFailed failed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };

    //this is triggred when the sms sent to the user
    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) async {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    } as PhoneCodeSent;

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      this.verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.phoneNumber.toString(),
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
