import 'package:baztami_app_flutter/config/palette.dart';
import 'package:baztami_app_flutter/config/styles.dart';
import 'package:baztami_app_flutter/screens/client_screen.dart';
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
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              topcards(
                title: "Payé",
                sum : "+ 3789 DH"
              ),
               SizedBox(
                 width: 20,
               ),
               topcards(
                   title: "Reste à Payer",
                   sum : "- 1300 DH"
               )
             ],
           ),

            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "Clients :",
                  style: Styles.headingStyle,
                  textAlign: TextAlign.start,
                ),
                Spacer(),
                FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: new Icon(Icons.account_balance_wallet_rounded),
                                  title: new Text('+/-'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.account_box),
                                  title: new Text('nom du client'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.monetization_on),
                                  title: new Text('montant'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.date_range),
                                  title: new Text('date'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  backgroundColor:Palette.primaryLightColor,
                 // icon: Icon(Icons.account_circle),
                  label: Text("Ajouter un client"),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),

         Expanded(
           child: Container(
             child: ListView.builder(
             scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(right:10),
            itemCount:17 ,
              itemBuilder:(context,index){
                 return GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => ClientScreen()),
                       );
                     },
                     child: creditcard(
                       name :"SALMA CHANA" ,
                       date :"10/01/2020",
                       amount :"250"
                     )
                 );
               }
             )
           ),
         )


          ],
        )
      ),
    );
  }
}


class creditcard extends StatelessWidget{
  const creditcard(
      {Key? key,
        required this.name,
        required this.date,
        required this.amount})
      : super(key: key);

  final String name;
  final String date;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1) ,
                    shape :BoxShape.circle
                ),
                child: Center(
                  child: FlutterLogo(),
                ),
              ),
            ),

            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize : 15 ,
                          color : Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize : 15,
                          color : Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w200
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      amount,
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

        ),
        Divider()
      ],
    );
  }
}

class topcards extends StatelessWidget {
  const topcards(
      {Key? key,
        required this.title ,
        required this.sum
     })
      : super(key: key);

  final String title;
  final String sum;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Palette.grey1Color ,
                blurRadius: 5,
                offset: Offset(2, 2), // Shadow position
              ),]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Palette.grey2Color,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              sum,
              style: TextStyle(
                  color: Palette.primaryLightColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

    );
  }
}
