import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {Key? key,
      required this.date,
      required this.description,
      required this.isDepense,
      required this.amount})
      : super(key: key);

  final String date;
  final bool isDepense;
  final String description;
  final double amount;

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
                  isDepense
                      ? Icons.arrow_circle_up_rounded
                      : Icons.arrow_circle_down_rounded,
                  size: 40,
                  color: isDepense ? Palette.redColor : Palette.greenColor,
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                          color: Palette.primaryLightColor,
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
                    isDepense
                        ? "- " + amount.toString() + " DH"
                        : "+ " + amount.toString() + " DH",
                    style: TextStyle(
                        color:
                            isDepense ? Palette.redColor : Palette.greenColor,
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
