import 'dart:ffi';

import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/data/firestoreFunctions.dart';
import 'package:baztami_app_flutter/screens/wallet_historiques_screen.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:baztami_app_flutter/widgets/general_balance_grid_wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: "Baztami"),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Text(
                "Balance Géneral ",
                style: Styles.headingStyle,
                textAlign: TextAlign.start,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            GeneralBalanceGridWallet(),
            Row(children: [
              Text(
                "Historiques",
                style: Styles.headingStyle,
                textAlign: TextAlign.start,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            Expanded(child: WalletHistory())
          ],
        ),
      ),
    );
  }
}

class WalletHistory extends StatefulWidget {
  @override
  _WalletHistoryState createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirestoreFunctions()
            .getWalletHistory("RfRvhrKB4aOAF83DpL1fJFV8rsR2"),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong' + snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            return new ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WalletHistoriqueScreen(
                              date: DateFormat("dd-MM-yyyy")
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      data["date"].seconds * 1000))
                                  .toString(),
                              description: data["description"],
                              amount: data["amount"].toString(),
                              isDepense: data["isDepense"],
                              isHistorique: true,
                              historiqueID: document.id.toString(),
                            )),
                  );
                },
                child: CustomListItem(
                  date: DateFormat("dd-MM-yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          data["date"].seconds * 1000))
                      .toString(),
                  description: data["description"],
                  isDepense: data["isDepense"],
                  amount: double.parse(data["amount"].toString()),
                ),
              );
            }).toList());
          }
        },
      ),
    );
  }

  _amount(String amount, Color color) {
    return Text("${amount} DH",
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
