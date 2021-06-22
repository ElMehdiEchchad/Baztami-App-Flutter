import 'package:flutter/material.dart';
import 'package:baztami_app_flutter/config/config.dart';

import 'client_screen.dart';

class YredScreen extends StatefulWidget {
  const YredScreen({Key? key}) : super(key: key);

  @override
  _YredScreenState createState() => _YredScreenState();
}

class _YredScreenState extends State<YredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ClientScreen()),
                      );
                    },
                    icon: Image.asset("assets/images/retourblue.png"),
                  ),
                  SizedBox(width: 90),
                  Text(
                    "NAME",
                    style: TextStyle(
                      color: Palette.primaryLightColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
            Center(child: Container(
              height: 100,
              margin: const EdgeInsets.only(top:50, bottom: 50, left: 50, right: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.grey1Color ,
                      blurRadius: 5,
                      offset: Offset(2, 2),         
              ),]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 150, 
            child:TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Palette.primaryLightColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0.00",
                hintStyle: TextStyle(
                  color: Palette.primaryLightColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              )
            ),),
            Text("DH", style: TextStyle(
              color: Palette.primaryLightColor,
              fontSize: 40,
              fontWeight: FontWeight.w700,),),
          ],
        ),
       ),),
       SizedBox(height: 60),
            ElevatedButton(onPressed: () {}, 
              child: Text(
                    "VALIDER",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.backgroundColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 60, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: Palette.primaryLightColor,
                  ),),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ClientScreen()),
                      );}, 
              child: Text(
                    "ANNULER",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Palette.backgroundColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 60, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: Palette.redColor,
                  ),)
      ],),), );
     
  }
}