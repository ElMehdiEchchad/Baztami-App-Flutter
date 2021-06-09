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
            children: [_buildCard("", ""), _buildCard("", "")],
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
          color: Palette.grey1Color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
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
