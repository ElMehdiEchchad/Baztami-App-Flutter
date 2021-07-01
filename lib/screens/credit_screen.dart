import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/config/styles.dart';
import 'package:baztami_app_flutter/screens/addclient.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:baztami_app_flutter/screens/client_screen.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final String userid = FirebaseAuth.instance.currentUser!.uid;
  int entree = 0;
  int sortie = 0;

  getuserdata() async {
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
  }

  void getdata() async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection("Users").doc(userid).get();
    setState(() {
      entree = variable["entrée"];
      sortie = variable["sortie"];
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    getdata();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: "Baztami"),
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Balance Géneral :",
                    style: Styles.headingStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(userid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: new CircularProgressIndicator());
                        return topcards(
                            title: "Entrée",
                            sum: "+ " +
                                (snapshot.data!)["entrée"].toString() +
                                " DH");
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(userid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: new CircularProgressIndicator());
                        return topcards(
                            title: "Sortie",
                            sum: "- " +
                                (snapshot.data!)["sortie"].toString() +
                                " DH");
                      }),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Clients :",
                    style: Styles.headingStyle,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return AddClient();
                        },
                        fullscreenDialog: true,
                      ));
                    },
                    backgroundColor: Palette.primaryLightColor,
                    // icon: Icon(Icons.account_circle),
                    label: Text("Ajouter un client"),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(userid)
                            .collection("Clients")
                            .orderBy("date", descending: false)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                                child: new CircularProgressIndicator());
                          /*     if((snapshot.data!).docs.length==0) return
                          Stack(
                   fit: StackFit.expand, // StackFit.expand fixes the issue
                  children: <Widget>[
                        Center(
                     child: Image.asset(
                     'assets/images/no-clients.png',
                       ),
                         ),
                        ],
                         );*/
                          return new ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(right: 10),
                              itemCount: (snapshot.data!).docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                    //  getuserdata();
                                      Navigator.of(context).push(new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return ClientScreen(
                                              clientid: (snapshot.data!)
                                                  .docs[index]
                                                  .id);
                                        },
                                        fullscreenDialog: true,));
                                     /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ClientScreen(
                                                clientid: (snapshot.data!)
                                                    .docs[index]
                                                    .id)
                                        ),
                                      );*/
                                    },
                                    child: CustomListItem(
                                        date: (snapshot.data!).docs[index]
                                            ["name"],
                                        description: (snapshot.data!)
                                            .docs[index]["date"],
                                        isDepense: (snapshot.data!).docs[index]
                                            ["isSalaf"],
                                        amount: double.parse((snapshot.data!)
                                            .docs[index]["amount"])));
                              });
                        })),
              )
            ],
          )),
    );
  }
}

class topcards extends StatelessWidget {
  const topcards({Key? key, required this.title, required this.sum})
      : super(key: key);

  final String title;
  final String sum;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Palette.grey1Color,
                blurRadius: 5,
                offset: Offset(2, 2), // Shadow position
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Palette.grey2Color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              sum,
              style: TextStyle(
                  color: Palette.primaryLightColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
