import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/screens/screens.dart';
import 'package:flutter/material.dart';

class NaVBottomBar extends StatefulWidget {
  @override
  _NaVBottomBarState createState() => _NaVBottomBarState();
}

class _NaVBottomBarState extends State<NaVBottomBar> {
  int state = 0;
  var _screens = [WalletScreen(), CreditScreen(), ProfileScreen()];

  _onItemTapped(index) {
    setState(() {
      this.state = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[state],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [Icons.account_balance_wallet_rounded, Icons.receipt, Icons.person]
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              BottomNavigationBarItem(
                label: "",
                icon: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: state == key
                        ? Palette.primaryLightColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Icon(value),
                ),
              ),
            ),
          )
          .values
          .toList(),
      currentIndex: state,
      selectedItemColor: Palette.backgroundColor,
      unselectedItemColor: Palette.grey1Color,
      backgroundColor: Palette.backgroundColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
  }
}
