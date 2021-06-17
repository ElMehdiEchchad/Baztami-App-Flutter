import 'package:baztami_app_flutter/config/palette.dart';
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
              _buildCard("Totale", "5000 DH "),
              _buildCard("Totale", "5000 DH ")
            ],
          )
        ],
      ),
    );
  }

  Expanded _buildCard(String title, String count) {
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
              Palette.primaryDark2Color,
            ],
          ),
          //color: Palette.grey1Color,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.add))
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
              Palette.primaryColor,
              Palette.primaryDark2Color,
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
}
