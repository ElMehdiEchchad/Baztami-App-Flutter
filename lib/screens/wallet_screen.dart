import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:baztami_app_flutter/widgets/custom_list_item_in_wallet.dart';
import 'package:baztami_app_flutter/widgets/general_balance_grid_wallet.dart';
import 'package:flutter/material.dart';

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
      child: ListView(children: <Widget>[
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
        CustomListItem(
          title: "SDSDS sgdgsgdgs sgdfsdgsds sdgsdgs",
          description: "HGSDHSD sssssssssssssssssssssssssssssssssss",
          icon: Icons.arrow_circle_down_rounded,
          amount: "- 34 DH",
          color: Colors.red,
        ),
      ]),
    );
  }

  _amount(String amount, Color color) {
    return Text("${amount} DH",
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
