import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
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
                      Navigator.push(
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
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
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
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                      SizedBox(
                        height: 90,
                        child: Text(
                          "-40 DH",
                          style: TextStyle(
                            color: Palette.redColor,
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
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
                                width: 50,
                                height: 50,
                                child: new Center(
                                  child: new IconButton(
                                    onPressed: () {},
                                    icon:
                                        Image.asset("assets/images/ysalef.png"),
                                  ),
                                )),
                            Text(
                              "YSALEF",
                              style: TextStyle(
                                color: Palette.backgroundColor,
                                fontSize: 13,
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
                                width: 50,
                                height: 50,
                                child: new Center(
                                  child: new IconButton(
                                    onPressed: () {},
                                    icon: Image.asset("assets/images/yrad.png"),
                                  ),
                                )),
                            Text(
                              "YRAD",
                              style: TextStyle(
                                color: Palette.backgroundColor,
                                fontSize: 13,
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
                                width: 50,
                                height: 50,
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
                                fontSize: 13,
                              ),
                            )
                          ]),
                        ],
                      )
                    ],
                  )),
            ),
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
