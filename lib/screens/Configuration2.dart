import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:baztami_app_flutter/services/authservice.dart';

class Configuration2 extends StatefulWidget {
  const Configuration2({Key? key}) : super(key: key);

  @override
  _Configuration2State createState() => _Configuration2State();
}

class _Configuration2State extends State<Configuration2> {
  final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;
  String username = "";
  String myPhoneNumber = "";
  String firstname = "";
  String lastname = "";
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  String updatedUsername = "";
  String updatedFirstName = "";
  String updatedLastName = "";

  void getdata() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .get();
    setState(() {
      username = variable["username"];
      myPhoneNumber = variable["phoneNumber"];
      firstname = variable["firstname"];
      lastname = variable["lastname"];
      // print(username);
    });
  }

  @override
  void initState() {
    getdata();
  }

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
        child: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                      leading: Icon(Icons.phone_in_talk),
                      title: Text(
                        "Mon numéro de téléphone",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: Text(
                        (snapshot.data!)["phoneNumber"].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ));
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!(snapshot.hasData)) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  ////////////////////////////////
                  /////////////////////
                  else if ((snapshot.data!)["username"] == " ") {
                    return ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text(
                        "Mon Nom d'utilisateur",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Saisissez votre nom d'utilisateur",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          updatedUsername = usernameController.text;
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(cuurentUserID)
                              .update({"username": updatedUsername});
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    );
                  }
                  ///////////////////////////////////////////
                  /////////////////

                  else {
                    return ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text(
                        "Mon Nom d'utilisateur",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: (snapshot.data!)["username"],
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          updatedUsername = usernameController.text;
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(cuurentUserID)
                              .update({"username": updatedUsername});
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    );
                  }
                }),
          ),

          ///////////////////////////////
          ///
          ///
          /////////////////////////////
          ///
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!(snapshot.hasData)) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  ////////////////////////////////
                  /////////////////////
                  else if ((snapshot.data!)["firstname"] == " ") {
                    return ListTile(
                        leading: Icon(Icons.supervised_user_circle),
                        title: Text(
                          "Mon prénom",
                          style: TextStyle(color: Colors.lightBlue[200]),
                        ),
                        subtitle: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: "Saisisez votre prénom",
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              updatedFirstName = firstNameController.text;
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(cuurentUserID)
                                  .update({"firstname": updatedFirstName});
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 30.0,
                            )));
                  }
                  ///////////////////////////////////////////
                  /////////////////

                  else {
                    return ListTile(
                      leading: Icon(Icons.supervised_user_circle),
                      title: Text(
                        "Mon prénom",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: (snapshot.data!)["firstname"],
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          updatedFirstName = firstNameController.text;
                          // print(firstNameController.text); good
                          // print(updatedFirstName); good
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(cuurentUserID)
                              .update({"firstname": updatedFirstName});
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    );
                  }
                }),
          ),

          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!(snapshot.hasData)) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  ////////////////////////////////
                  /////////////////////
                  else if ((snapshot.data!)["lastname"] == " ") {
                    return ListTile(
                        leading: Icon(Icons.supervised_user_circle),
                        title: Text(
                          "Mon Nom",
                          style: TextStyle(color: Colors.lightBlue[200]),
                        ),
                        subtitle: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: "Saisisez votre nom",
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              updatedLastName = lastNameController.text;
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(cuurentUserID)
                                  .update({"lastname": updatedLastName});
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 30.0,
                            )));
                  }
                  ///////////////////////////////////////////
                  /////////////////

                  else {
                    return ListTile(
                      leading: Icon(Icons.supervised_user_circle),
                      title: Text(
                        "Mon Nom",
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ),
                      subtitle: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: (snapshot.data!)["lastname"],
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          updatedLastName = lastNameController.text;
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(cuurentUserID)
                              .update({"lastname": updatedLastName});
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    );
                  }
                }),
          ),

          SizedBox(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Pour mettre à jour vos informations, saisissez les dans les champs convenables, et appuyez sur le boutton à droite pour enregistrer!',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          )),

          /* Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon nom d'utilisateur",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["username"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: new CircularProgressIndicator());
                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon Prénom",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["firstname"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.all(4.0),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(cuurentUserID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: new CircularProgressIndicator());
                  }

                  return ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text(
                      "Mon Nom",
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      (snapshot.data!)["lastname"].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  );
                }),
          ),*/
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // background color
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () => {_showMyDialog()},
                icon: Icon(Icons.delete_forever),
                label: Text(
                  "Supprimer mon compte",
                )),
          ),
        ]),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, //the user can dispose of the alert box either by pressing a cancel button or by pressing anywhere other the alert itself

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmez votre action.'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Etes vous sûres de vouloir Supprimer votre compte?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmer'),
              onPressed: () {
                String currentid = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(currentid)
                    .delete();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));

                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
