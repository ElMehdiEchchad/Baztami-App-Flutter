import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/config/styles.dart';
import 'package:baztami_app_flutter/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: "Baztami"),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child :Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [
              Text(
                "Balance Géneral :",
                style: Styles.headingStyle,
                textAlign: TextAlign.start,
              ),],) ,
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Palette.grey1Color,
                  borderRadius: BorderRadius.circular(10),
                ),),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Clients :",
                  style: Styles.headingStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),

         Container(
           height: 500,
           child: ListView.builder(
           scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left:16 , right:6),
          itemCount:7 ,
            itemBuilder:(context,index){
               return creditcard();
             }
           )
         )


          ],
        )
      ),
    );
  }
}


class creditcard extends StatefulWidget {


  @override
  _creditcardState createState() => _creditcardState();
}

class _creditcardState extends State<creditcard> {
  @override
  Widget build(BuildContext context) {
    return    Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1) ,
              shape :BoxShape.circle
          ),
          child: Center(
            child: FlutterLogo(),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MOHAMMED ALAMI",
                style: TextStyle(
                    fontSize : 15 ,
                    color : Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                " 20/02/2019",
                style: TextStyle(
                    fontSize : 15,
                    color : Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w200
                ),
              ),

            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " 245 DH",
                  style: TextStyle(
                      fontSize : 15,
                      color : Colors.red,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
