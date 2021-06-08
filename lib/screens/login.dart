import 'package:baztami_app_flutter/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'nav_bottom_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }

  _handleLogin() {
    if (phoneNumber.dialCode.toString().length <
        phoneNumber.phoneNumber.toString().length) {
      //check number in firebase

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NaVBottomBar()),
      );
    }
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
}
