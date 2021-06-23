import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:flutter/material.dart';
import 'EditClient.dart';
import 'ysalef_screen.dart';
import 'yred_screen.dart';

import 'screens.dart';

class ClientScreen extends StatefulWidget {

  final String clientid;
  const ClientScreen({Key,key, required this.clientid}) : super(key: key);


  @override
  _ClientScreenState createState() => _ClientScreenState(this.clientid);
}

class _ClientScreenState extends State<ClientScreen> {
  final String clientid;
  _ClientScreenState(this.clientid);
  @override
  void initState  () {
    // TODO: implement initState
    super.initState();
    print(clientid);
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryLightColor,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => CreditScreen()),
                      );
                    },
                    icon: Image.asset("assets/images/retour.png"),
                  ),
                  Spacer(),
                  Text(
                    "NAME",
                    style: TextStyle(
                      color: Palette.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditClient(clientid: clientid,)),
                      );},
                    icon: Image.asset("assets/images/editer.png"),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text("CHHAL 3ANDO",
                            style: TextStyle(
                              color: Palette.backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                      SizedBox(
                        height: 70,
                        child: Text(
                          "-40 DH",
                          style: TextStyle(
                            color: Palette.redColor,
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Palette.grey4Color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 45,
                                height: 45,
                                child: new Center(
                                  child: new IconButton(
                                    onPressed: () {Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => YsalefScreen(clientid:clientid)),
                                        );},
                                    icon:
                                        Image.asset("assets/images/ysalef.png"),
                                  ),
                                )),
                            Text(
                              "YSALEF",
                              style: TextStyle(
                                color: Palette.backgroundColor,
                                fontSize: 11,
                              ),
                            )
                          ]),
                          SizedBox(width: 10),
                          Column(children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Palette.grey4Color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 45,
                                height: 45,
                                child: new Center(
                                  child: new IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => YredScreen(clientid: clientid)),
                                        );
                                    },
                                    icon: Image.asset("assets/images/yrad.png"),
                                  ),
                                )),
                            Text(
                              "YRAD",
                              style: TextStyle(
                                color: Palette.backgroundColor,
                                fontSize: 11,
                              ),
                            )
                          ]),
                          SizedBox(width: 10),
                          Column(children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Palette.grey4Color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 45,
                                height: 45,
                                child: new Center(
                                  child: new IconButton(
                                    onPressed: () {},
                                    icon:
                                        Image.asset("assets/images/phone.png"),
                                  ),
                                )),
                            Text(
                              "APPEL",
                              style: TextStyle(
                                color: Palette.backgroundColor,
                                fontSize: 11,
                              ),
                            )
                          ]),
                        ],
                      )
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Expanded(child: ClientHistory()),
          ],
        ),
      ),
    );
  }
}

class ClientHistory extends StatefulWidget {
  @override
  _ClientHistoryState createState() => _ClientHistoryState();
}

class _ClientHistoryState extends State<ClientHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      decoration: BoxDecoration(
        color: Palette.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Historique",
                style: Styles.headingStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        Expanded(child: ClientHistoryCard())
      ]),
    );
  }
}

class ClientHistoryCard extends StatefulWidget {
  @override
  _ClientHistoryCardState createState() => _ClientHistoryCardState();
}

class _ClientHistoryCardState extends State<ClientHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
        CustomListItem(
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          isDepense: true,
          amount: 35,
        ),
      ],
    ));
  }
}
