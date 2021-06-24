import 'package:baztami_app_flutter/screens/ProfileScreen.dart';
import 'package:baztami_app_flutter/widgets/BoxInfo.dart';
import 'package:flutter/material.dart';
import 'package:baztami_app_flutter/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

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
            /*Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()))*/
            Navigator.pop(context)
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
            Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.primaryColor,
                          Palette.primaryHeadingColor
                        ]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  leading: Icon(Icons.phone_in_talk),
                  title: Text(
                    'Contactez nous par téléphone ',
                    style: TextStyle(color: Colors.lightBlue[200]),
                  ),
                  subtitle: Text(
                    "Appelez nous!",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onTap: () => {launch("tel:+212707102960")},
                )),
            Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.primaryColor,
                          Palette.primaryHeadingColor
                        ]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                    leading: Icon(Icons.web),
                    title: Text(
                      'Rendez vous sur notre site Web',
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      "Our Website",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onTap: () => {})),
            Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.primaryColor,
                          Palette.primaryHeadingColor
                        ]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                    leading: Icon(Icons.web),
                    title: Text(
                      'Rendez vous sur notre Page Facebook',
                      style: TextStyle(color: Colors.lightBlue[200]),
                    ),
                    subtitle: Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onTap: () => {_launchFacebook()})),
            Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.primaryColor,
                          Palette.primaryHeadingColor
                        ]),
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'Emailez nous',
                    style: TextStyle(color: Colors.lightBlue[200]),
                  ),
                  subtitle: Text(
                    "Contactez nous par mail",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onTap: () => {_launchEmail()},
                )),
          ],
        ),
      ),
    );
  }
}

_launchFacebook() async {
  const url = "facebook.com";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'elmehdiechchad@gmail.com',
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
