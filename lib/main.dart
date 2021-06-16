import 'package:baztami_app_flutter/screens/ProfileScreen.dart';
import 'package:baztami_app_flutter/screens/nav_bottom_bar.dart';
import 'package:baztami_app_flutter/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baztami',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "BalooTammudu2",
      ),
      //home: AuthService().handleAuth(),
      home: ProfileScreen(),
    );
  }
}
