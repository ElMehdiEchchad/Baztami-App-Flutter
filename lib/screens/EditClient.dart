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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                    await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc(clientid).update({
                  "name": name.text,
                  "phonenumber": phonenumber.text,
                });
                Navigator.pop(context);
              }
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
              int entree = 0;
              int sortie = 0;

              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('Users').doc(userid)
                  .collection('Clients')
                  .get();
              final allData = querySnapshot.docs.map((doc) => doc.data())
                  .toList();
              setState(() {
                for (var client in allData) {
                  if ((client as Map)["isSalaf"] == true)
                    sortie += int.parse((client as Map)["amount"]);
                  else
                    entree += int.parse((client as Map)["amount"]);
                }
              });

              await FirebaseFirestore.instance.collection("Users").doc(
                  userid).update({
                "entrée": entree,
                "sortie": sortie
              });
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
    ),));
  }
}