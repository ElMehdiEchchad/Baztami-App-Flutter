import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
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
                "Balance Géneral :",
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
      child: ListView(children: const <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          shadowColor: Palette.backgroundColor,
          elevation: 10,
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
            subtitle: Text('One-line with leading widget'),
            trailing: FlutterLogo(),
          ),
        ),
      ]),
    );
  }
}
