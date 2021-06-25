import 'package:baztami_app_flutter/screens/Configuration2.dart';
import 'package:baztami_app_flutter/screens/MyInfo.dart';
import 'package:baztami_app_flutter/screens/NousContacter.dart';
import 'package:baztami_app_flutter/services/authservice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:baztami_app_flutter/config/config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    this.initMyLibrary();
  }

  void initMyLibrary() {
    LicenseRegistry.reset();
    LicenseRegistry.addLicense(() async* {
      yield LicenseEntryWithLineBreaks(<String>['Privacy and Policy:'], '''
  Copyright 2016 Woolha. All rights reserved.
  
     * in our app you data and your number is secure. 
   
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS''');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   color: Palette.primaryDark2Color,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => CreditScreen()),
        //     );
        //   },
        // ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
          child: Text(
            'Profil',
            style: TextStyle(
                color: Palette.primaryHeadingColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Palette.backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Palette.primaryHeadingColor,
            ),
            iconSize: 28.0,
            onPressed: () => {_showMyDialog()},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    // leading: Icon
                    title: Text(
                      'Information',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    leading: Icon(
                      Icons.person_rounded,
                      size: 28.0,
                      color: Palette.primaryDarkColor,
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyInfo()))
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    // leading: Icon
                    title: Text(
                      'Configuration',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    leading: Icon(
                      Icons.person_rounded,
                      size: 28.0,
                      color: Palette.primaryDark2Color,
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Configuration2()))
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    // leading: Icon
                    title: Text(
                      'Nous contacter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    leading: Icon(
                      Icons.person_rounded,
                      size: 28.0,
                      color: Palette.primaryHeadingColor,
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactUs()))
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    // leading: Icon
                    title: Text(
                      'A propos de Baztami',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    leading: Icon(
                      Icons.person_rounded,
                      size: 28.0,
                      color: Palette.primaryColor,
                    ),
                    trailing: Icon(Icons.arrow_right_outlined),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Icon(
                          Icons.account_balance_wallet,
                          color: Palette.primaryLightColor,
                          size: 30,
                        ),
                        applicationName: 'BAZTAMI APP',
                        applicationVersion: '0.0.1',
                        applicationLegalese: '©2021 baztami',
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'This is an e-wallet application created by the Team : '),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('MAJID Omayma'),
                                  Text('CHANA Salma'),
                                  Text('ECHCHAD El Mehdi'),
                                  Text('LKHADIR Mostapha'),
                                ],
                              ))
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, //the user can dispose of the alert box either by pressing a cancel button or by pressing anywhere other the alert itself

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmez votre action.'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Etes vous sûres de vouloir vous déconnecter?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop();
                AuthService().signOut();
              },
            ),
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
