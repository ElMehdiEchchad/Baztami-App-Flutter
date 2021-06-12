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
        //resizeToAvoidBottomInset: false,
        backgroundColor: Palette.backgroundColor,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: _welcomeImage(),
              ),
              Flexible(
                flex: 3,
                child: InternationalPhoneInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _welcomeImage() {
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
              child: Text(
                codeSent
                    ? "Veuillez saisir le code qui va vous arriver par SMS"
                    : "Veuillez saisir votre numéro de telephone",
                style: TextStyle(
                    color: Palette.primaryHeadingColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
            ),
            codeSent
                ? Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration:
                          InputDecoration(hintText: 'Enter OTP : XXXXXX'),
                      onChanged: (val) {
                        setState(() {
                          this.smsCode = val;
                        });
                      },
                    ),
                  )
                : Center(
                    child: InternationalPhoneNumberInput(
                      countrySelectorScrollControlled: true,
                      initialValue: PhoneNumber(
                        isoCode: "MA",
                      ),
                      hintText: "Enter votre num...",
                      onInputChanged: (PhoneNumber value) =>
                          _handleInput(value),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Entrer votre numero de telphone. En cas de perte ou changement de telephone vous pourriez acceder à votre compte par votre numero de telephone",
                style: TextStyle(
                  color: Palette.grey1Color,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          showLoading
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 60, 50),
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

  _handleLogin() async {
    if (phoneNumber.dialCode.toString().length <
        phoneNumber.phoneNumber.toString().length) {
      setState(() {
        showLoading = true;
      });
      //check number in firebase
      if (codeSent) {
        await AuthService().signInWithOTP(smsCode, verificationId)
            //     .then((value) => null)
            //     .catchError((e) {
            //   setState(() {
            //     showLoading = false;
            //   });
            //   showDialogMessage("Error", e.toString());
            // })
            ;
      } else {
        verifyPhone(phoneNumber);
      }
    } else
      (ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('numero incorrecte'))));
  }

  void showDialogMessage(String error, String text) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(error),
              content: Text(text),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  Future<void> verifyPhone(PhoneNumber phoneNumber) async {
    //when num is verified
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      //sign in with credentiels
      AuthService().signIn(authResult);
      setState(() {
        showLoading = false;
      });
    };

    //this for handle the error message
    final PhoneVerificationFailed failed = (FirebaseAuthException e) {
      setState(() {
        showLoading = false;
      });
      if (e.code == 'invalid-phone-number') {
        showDialogMessage("Erreur",
            'votre numero n\'est pas valide, essayez de saisir un numero valide');
      } else if (e.code == 'too-many-requests') {
        showDialogMessage("Erreur",
            'votre némuro est bloqué temporairement, veuillez reussir plus tard');
      } else {
        showDialogMessage("Erreur", e.toString());
      }
    };

    //this is triggred when the sms sent to the user
    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) async {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
        this.showLoading = false;
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
