import 'package:baztami_app_flutter/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import '/config/Palette.dart';
import '/screens/MyInfo.dart';

class BoxInfo extends StatelessWidget {
  final String MainTitle;
  final String subTitle;
  final Icon LeadingIcon;
  const BoxInfo({
    Key? key,
    required this.MainTitle,
    required this.subTitle,
    required this.LeadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Palette.primaryColor, Palette.primaryHeadingColor]),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          leading: LeadingIcon,
          title: Text(
            '${MainTitle}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '${subTitle}',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => {},
        ));
  }
}
