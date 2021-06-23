import 'package:baztami_app_flutter/screens/ProfileScreen.dart';
import 'package:baztami_app_flutter/widgets/BoxInfo.dart';
import 'package:flutter/material.dart';
import 'package:baztami_app_flutter/config/config.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()))
          },
          icon: Icon(Icons.arrow_back),
          color: Palette.primaryDark2Color,
        ),
        title: Text('Contact Us',
            style: TextStyle(
                color: Palette.primaryHeadingColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            BoxInfo(
                MainTitle: "Your name",
                subTitle: "THIS IS IT",
                LeadingIcon: Icon(Icons.supervised_user_circle))
          ],
        ),
      ),
    );
  }
}
