import 'package:baztami_app_flutter/blocs/bloc/currentuser_bloc.dart';
import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:baztami_app_flutter/screens/wallet_historiques_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GeneralBalanceGridWallet extends StatefulWidget {
  const GeneralBalanceGridWallet({Key? key}) : super(key: key);

  @override
  _GeneralBalanceGridWalletState createState() =>
      _GeneralBalanceGridWalletState();
}

class _GeneralBalanceGridWalletState extends State<GeneralBalanceGridWallet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<CurrentuserBloc, CurrentuserState>(
        builder: (context, state) {
          if (state is CurrentUserLoaded) {
            return Column(
              children: [
                Row(
                  children: [
                    _buildCardGenaral("Totale",
                        state.currentUser.balanceGeneral.toString() + " DH")
                  ],
                ),
                Row(
                  children: [
                    _buildCardADD("Revenus",
                        state.currentUser.revenues.toString() + " DH"),
                    _buildCardMinus("Depenses",
                        state.currentUser.depenses.toString() + " DH")
                  ],
                )
              ],
            );
          }
          if (state is CurrentUserFailed) {
            return Center(child: Text("ERROR"));
          }
          if (state is CurrentUserLoading) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Row(
                  children: [_buildCardGenaral("Totale", "-   DH")],
                ),
                Row(
                  children: [
                    _buildCardADD("Revenus", "-    DH"),
                    _buildCardMinus("Depenses", "-   DH")
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }

  Expanded _buildCardMinus(String title, String count) {
    return (Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              Palette.primaryLightColor,
              Palette.primaryDark2Color.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
                Text(
                  count,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Palette.grey1Color.withOpacity(0.5),
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            child: IconButton(
              icon: const Icon(
                Icons.remove_circle,
                color: Palette.backgroundColor,
                size: 30,
              ),
              tooltip: 'ajouter des depenses',
              onPressed: () {
                _handleRemoveDepenses();
              },
            ),
          )
        ]),
      ),
    ));
  }

  Expanded _buildCardADD(String title, String count) {
    return (Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              Palette.primaryLightColor,
              Palette.primaryDark2Color.withOpacity(0.9),
            ],
          ),
          //color: Palette.grey1Color,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
                Text(
                  count,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Palette.grey1Color.withOpacity(0.5),
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Palette.backgroundColor,
                size: 30,
              ),
              tooltip: 'ajouter des Revenus',
              onPressed: () {
                _handleAddRevenu();
              },
            ),
          )
        ]),
      ),
    ));
  }

  Expanded _buildCardGenaral(String title, String count) {
    return (Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.1, 0.9],
            colors: [
              Palette.primaryLightColor,
              Palette.primaryDark2Color.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w200),
            ),
            Text(
              count,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ));
  }

  _handleAddRevenu() {
    String now = DateFormat("dd-MM-yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch))
        .toString();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalletHistoriqueScreen(
          isHistorique: false,
          walletTransaction: new WalletTransaction(Uuid().v1(),
              amount: 0.0,
              date: Timestamp.fromDate(DateTime.now()),
              description: "",
              isDepense: false),
        ),
      ),
    );
  }

  _handleRemoveDepenses() {
    String now = DateFormat("dd-MM-yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch))
        .toString();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WalletHistoriqueScreen(
            isHistorique: false,
            walletTransaction: new WalletTransaction(Uuid().v1(),
                amount: 0.0,
                date: Timestamp.fromDate(DateTime.now()),
                description: "",
                isDepense: true),
          ),
        ));
  }
}
