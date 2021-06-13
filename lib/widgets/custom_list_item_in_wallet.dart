import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.color,
      required this.amount})
      : super(key: key);

  final IconData icon;
  final String title;
  final String description;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        shadowColor: Palette.backgroundColor,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Palette.primaryHeadingColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          height: 1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          color: Palette.grey1Color,
                          fontWeight: FontWeight.w300,
                          height: 1),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    amount,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
