import 'package:baztami_app_flutter/config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'client_screen.dart';
import 'credit_screen.dart';


class EditClient extends StatefulWidget {
  final String clientid;
  const EditClient({Key,key , required this.clientid }) : super(key: key);

  @override
  _EditClientState createState() => _EditClientState(this.clientid);
}

class _EditClientState extends State<EditClient> {
  final String userid = FirebaseAuth.instance.currentUser!.uid ;
  final String clientid;
  TextEditingController name = new TextEditingController() ;
  TextEditingController phonenumber = new TextEditingController() ;
  _EditClientState(this.clientid);

  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ClientScreen(clientid: clientid)),
                      );
                    },
                    icon: Image.asset("assets/images/retourblue.png"),
                  ),
                  SizedBox(width: 100),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userid).collection("Clients").doc(clientid)
                        .snapshots(),
                    builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData)
                                      return Center(child: new Text(""));
                                    return Text(snapshot.data!["name"], style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),);
                    }),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("  NOM", 
                  style: TextStyle(color: Palette.primaryLightColor),
              ),
               StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userid).collection("Clients").doc(clientid)
                        .snapshots(),
                    builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData)
                                      return Center(child: new Text(""));
                                    return Container(
                                          height: 50,
                                          child: TextFormField(
                                                key: _formKeyName,
                                                controller: name,
                                                decoration: InputDecoration(
                                                  hintText: snapshot.data!["name"],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                                  Radius.circular(15.0)),
                                                  ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'This field should not be empty';
                                                    }}
                                      ),
                                        );
               }),
              SizedBox(height:30),
              Text("  NUM TELEPHONE", style: 
                  TextStyle(color: Palette.primaryLightColor),
                  ),
              StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userid).collection("Clients").doc(clientid)
                        .snapshots(),
                    builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData)
                                      return Center(child: new Text(""));
                                    return Container(
                                          height: 50,
                                          child: TextFormField(
                                                key: _formKeyPhone,
                                                controller: phonenumber,
                                                keyboardType: TextInputType.phone,
                                                decoration: InputDecoration(
                                                  hintText: snapshot.data!["phonenumber"],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                                  Radius.circular(15.0))
                                                  ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'This field should not be empty';
                                                    }}
                                      ),
                                        );
               }),
               ],),
            ),
            SizedBox(height: 60),
            ElevatedButton(onPressed: () async{
              await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc(clientid).update({
                  "name": name.text,
                  "phonenumber": phonenumber.text,
                });
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ClientScreen(clientid: clientid,)),
                      );
              
            }, 
              child: Text(
                    "VALIDER",
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
                  ),),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () async{
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreditScreen()),
              );
              await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc(clientid).delete();                 
            }, 
              child: Text(
                    "SUPPRIMER",
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
                    primary: Palette.redColor,
                  ),)
            ],),
    ));
  }
}