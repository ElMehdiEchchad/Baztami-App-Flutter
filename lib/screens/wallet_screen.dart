import 'package:baztami_app_flutter/blocs/walletTransaction_bloc/walletTransaction_bloc.dart';
import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/data/firebase_wallets_repository.dart';
import 'package:baztami_app_flutter/models/models.dart';

import 'package:baztami_app_flutter/screens/wallet_historiques_screen.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:baztami_app_flutter/widgets/custom_loading_wallet_screen_shimmer_effect_wallet.dart';
import 'package:baztami_app_flutter/widgets/general_balance_grid_wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider<WalletBloc>(
        //   create: (context) {
        //     return WalletBloc(
        //       walletTransactionRepository: FirebaseWalletTransactionsRepository(),
        //     )..add(LoadWalletTransactions());
        //   },
        //   child:
        Scaffold(
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
      //),
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
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state is WalletLoading) {
        return CustomLoadingWalletScreen();
      }
      if (state is WalletLoaded) {
        final walletTransactions = state.walletTransaction;
        if (walletTransactions.length == 0) {
          return Center(
              child: Text(
            "Pas de Historiques",
            style: TextStyle(
                color: Palette.grey1Color.withOpacity(0.3), fontSize: 40),
          ));
        } else {
          return ListView.builder(
              itemCount: walletTransactions.length,
              itemBuilder: (context, index) {
                final walletTransaction = walletTransactions[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletHistoriqueScreen(
                                  isHistorique: true,
                                  walletTransaction: walletTransaction,
                                )),
                      );
                    },
                    child: CustomListItem(
                      date: DateFormat("dd-MM-yyyy")
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              walletTransaction.date.seconds * 1000))
                          .toString(),
                      description: walletTransaction.description,
                      isDepense: walletTransaction.isDepense,
                      amount: double.parse(
                        walletTransaction.amount.toString(),
                      ),
                    ));
              });
        }
      } else {
        return CustomLoadingWalletScreen();
      }
    });

    // StreamBuilder<QuerySnapshot>(
    //   stream: FirestoreFunctions()
    //       .getWalletHistory("RfRvhrKB4aOAF83DpL1fJFV8rsR2"),
    //   builder: (BuildContext context, snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong' + snapshot.error.toString());
    //     } else if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     } else {
    //       return new ListView(
    //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //         Map<String, dynamic> data =
    //             document.data() as Map<String, dynamic>;
    //         return GestureDetector(
    //           onTap: () {
    //             //for test
    //             // BlocProvider.of<WalletBloc>(context).add(WalletAdded(
    //             //     new WalletTransactionModel("", "", "", true)));
    //             // Navigator.push(
    //             //   context,
    //             //   MaterialPageRoute(
    //             //       builder: (context) => WalletHistoriqueScreen(
    //             //             date: DateFormat("dd-MM-yyyy")
    //             //                 .format(DateTime.fromMillisecondsSinceEpoch(
    //             //                     data["date"].seconds * 1000))
    //             //                 .toString(),
    //             //             description: data["description"],
    //             //             amount: data["amount"].toString(),
    //             //             isDepense: data["isDepense"],
    //             //             isHistorique: true,
    //             //             historiqueID: document.id.toString(),
    //             //           )),
    //             // );
    //           },
    //           child: CustomListItem(
    //             date: DateFormat("dd-MM-yyyy")
    //                 .format(DateTime.fromMillisecondsSinceEpoch(
    //                     data["date"].seconds * 1000))
    //                 .toString(),
    //             description: data["description"],
    //             isDepense: data["isDepense"],
    //             amount: double.parse(data["amount"].toString()),
    //           ),
    //         );
    //       }).toList());
    //     }
    //   },
    // );
  }

  _amount(String amount, Color color) {
    return Text("${amount} DH",
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
