import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/BoxInfo.dart';
import 'package:baztami_app_flutter/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baztami_app_flutter/data/firestoreFunctions.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({
    Key? key,
  }) : super(key: key);

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()))
          },
          icon: Icon(Icons.arrow_back),
          color: Palette.primaryDark2Color,
        ),
        title: Text("Your Information",
            style: TextStyle(
                color: Palette.primaryHeadingColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              BoxInfo(
                  LeadingIcon: Icon(Icons.add),
                  MainTitle: "Hello " + GetPhoneNumber().toString(),
                  subTitle: "Test of subtitle"),
              BoxInfo(
                  LeadingIcon: Icon(Icons.ac_unit_outlined),
                  MainTitle: "Another one",
                  subTitle: "another one"),
              BoxInfo(
                  LeadingIcon: Icon(Icons.add_a_photo),
                  MainTitle: "A third box of info",
                  subTitle: "this is its description")
            ],
          )),
    );
  }
}

String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;
String GetPhoneNumber() {
  return FirebaseFirestore.instance
      .collection("Users")
      .doc(cuurentUserID)
      .collection("phoneNumber")
      .toString();
}

//here the info to go in the box is dynamic and will be retrieved from the backend
