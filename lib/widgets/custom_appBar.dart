import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String appBarTitle;
  const CustomAppBar({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.backgroundColor,
      centerTitle: false,
      title: Text("${widget.appBarTitle}",
          style: TextStyle(
              color: Palette.primaryDark2Color,
              fontSize: 25,
              fontWeight: FontWeight.bold)),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Palette.grey3Color,
          ),
          iconSize: 28.0,
          onPressed: () {},
        ),
      ],
    );
  }
}
