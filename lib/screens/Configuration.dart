import 'package:baztami_app_flutter/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;
bool state = false;

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
  TextEditingController usernameController = new TextEditingController();
  String usernameValue = "";

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
              //using containers for data is better for the state
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
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      'Mon numéro de téléphone ',
                      style: TextStyle(color: Colors.lightBlue[200]),
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
                    onTap: () => {Navigator.pop(context)},
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
                    leading: Icon(Icons.person),
                    title: Text(
                      'Mon nom d\'utilisateur',
                      style: TextStyle(color: Colors.lightBlue[200]),
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
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                    onTap: () => {updateUsername()}),
              ),

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
                    leading: Icon(Icons.supervised_user_circle),
                    title: Text(
                      'Mon prénom ',
                      style: TextStyle(color: Colors.lightBlue[200]),
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
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                    onTap: () => {},
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 25.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.primaryColor,
                          Palette.primaryHeadingColor
                        ]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.supervised_user_circle),
                    title: Text(
                      'Mon nom ',
                      style: TextStyle(color: Colors.lightBlue[200]),
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
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                    onTap: () => {},
                  )),
              Container(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // background color
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => {},
                    icon: Icon(Icons.delete_forever),
                    label: Text(
                      "Supprimer mon compte",
                    )),
              ),

              //All of what's below is for test purposes
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration:
                          InputDecoration(contentPadding: EdgeInsets.all(10.0)),
                    ),
                    ElevatedButton.icon(
                        onPressed: () => {
                              usernameValue = usernameController.text,
                            },
                        icon: Icon(Icons.save),
                        label: Text("Save"))
                  ],
                ),
              )
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

//This is a test function
  updateUsername() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .update({"username": "test"});
  }
}
