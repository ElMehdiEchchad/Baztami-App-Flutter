import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import '/screens/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WalletScreen())) //to be modified
          },
        ),
        title: Text('Home page'),
      ),
    );
  }
}
