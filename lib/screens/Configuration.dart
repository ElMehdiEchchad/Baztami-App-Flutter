import 'package:baztami_app_flutter/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;

class Configuration extends StatefulWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  String myPhoneNumber = "";
  String Username = "";
  String firstname = "";
  String lastname = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()))*/
            Navigator.pop(context)
          },
          icon: Icon(Icons.arrow_back),
          color: Palette.primaryDark2Color,
        ),
        title: Text("Configuration",
            style: TextStyle(
                color: Palette.primaryHeadingColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.primaryColor,
                            Palette.primaryHeadingColor
                          ]),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'My phone number ',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapchot) {
                        return Text(
                          myPhoneNumber,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        );
                      },
                    ),
                    onTap: () => {},
                  )),
              Container(
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.primaryColor,
                            Palette.primaryHeadingColor
                          ]),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'My username ',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapchot) {
                        return Text(
                          Username,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        );
                      },
                    ),
                    onTap: () => {},
                  )),
              Container(
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.primaryColor,
                            Palette.primaryHeadingColor
                          ]),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'My first name ',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapchot) {
                        return Text(
                          firstname,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        );
                      },
                    ),
                    onTap: () => {},
                  )),
              Container(
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Palette.primaryColor,
                            Palette.primaryHeadingColor
                          ]),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      'My last name ',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    subtitle: FutureBuilder(
                      future: getUserData(),
                      builder: (context, snapchot) {
                        return Text(
                          lastname,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        );
                      },
                    ),
                    onTap: () => {},
                  ))
            ],
          )),
    );
  }

  getUserData() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .get()
        .then((value) => {
              myPhoneNumber = value['phoneNumber'],
              Username = value['username'],
              firstname = value['firstname'],
              lastname = value['lastname']
              //  print(myPhoneNumber + "this"),
            });
  }
}
