import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/screens/wallet_historiques_screen.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          Row(
            children: [_buildCardGenaral("Totale", "5000 DH ")],
          ),
          Row(
            children: [
              _buildCardADD("Revenus", "5000 DH "),
              _buildCardMinus("Depenses", "50DH ")
            ],
          )
        ],
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
          //color: Palette.grey1Color,
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalletHistoriqueScreen(
          //add date of today
          date: "le 12/23/2020",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          amount: "00",
          isDepense: false,
          isHistorique: false,
        ),
      ),
    );
  }

  _handleRemoveDepenses() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WalletHistoriqueScreen(
            //add date of today
            date: "le 12/23/2020",
            description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
            amount: "00",
            isDepense: true,
            isHistorique: false,
          ),
        ));
  }
}
