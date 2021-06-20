import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({
    Key? key,
  }) : super(key: key);

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {},
          icon: Icon(Icons.arrow_back),
          color: Palette.primaryDark2Color,
        ),
        title: Text('Your Information',
            style: TextStyle(
                color: Palette.primaryDark2Color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Palette.primaryColor,
                        Palette.primaryHeadingColor
                      ])),
                  child: ListTile(
                    title: Text(
                      'This is a card test: your name',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Your name is flan',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Palette.primaryColor,
                        Palette.primaryHeadingColor
                      ])),
                  child: ListTile(
                    title: Text(
                      'This is a card test: your name',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Your name is flan',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  )),
            ],
          )),
    );
  }
}

//here the info to go in the box is dynamic and will be retrieved from the backend
