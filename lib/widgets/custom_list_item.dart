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

  final Icon icon;
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: icon,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [Text(title), Text(description)],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(amount),
            ),
          ],
        ),
      ),

      // ListTile(
      //       leading: Container(
      //         //color: Colors.amber,
      //         // height: double.infinity,
      //         child: const Icon(
      //           Icons.arrow_circle_down_rounded,
      //           color: Colors.red,
      //           size: 20,
      //         ),
      //       ),
      //       title: Text('One-line '),
      //       subtitle: Text('One-line with leading widget'),
      //       trailing: _amount("- 40", Colors.red),
      //     ),
    );
  }
}
