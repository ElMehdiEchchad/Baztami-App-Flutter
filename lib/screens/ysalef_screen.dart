import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:baztami_app_flutter/config/config.dart';
import 'package:intl/intl.dart';
import 'client_screen.dart';

class YsalefScreen extends StatefulWidget {
  final String clientid;
  const YsalefScreen({Key, key , required this.clientid}) : super(key: key);

  @override
  _YsalefScreenState createState() => _YsalefScreenState(this.clientid);
}

class _YsalefScreenState extends State<YsalefScreen> {
  final String clientid;
  _YsalefScreenState(this.clientid);

  final String userid = FirebaseAuth.instance.currentUser!.uid ;
  final  userCollection = FirebaseFirestore.instance.collection("Users");
  late String _date =new DateFormat.yMMMMd("en_US").format(new DateTime.now());
  TextEditingController amount = new TextEditingController() ;
  final _formKey = GlobalKey<FormState>();


  Future _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2030)
    );
    if(picked != null) setState(() => {_date = new DateFormat.yMMMMd("en_US").format(picked)
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset("assets/images/retourblue.png"),
                  ),
                  SizedBox(width: 100),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userid).collection("Clients").doc(clientid)
                        .snapshots(),
                    builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData)
                                      return Center(child: new CircularProgressIndicator());
                                    return Text(snapshot.data!['name'], style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),);
                    }),
                ],
              ),
            ),
            SizedBox(height: 120),
            Row(children: [
            Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left:40),
                          height: 50,
                          child: TextFormField(
                            controller: TextEditingController()..text = _date,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "Date ..",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                            ),
                            validator: (value) {
                                   if (value == null || value.isEmpty) {
                                        return 'This field should not be empty';
                            }}

                          ),
                        ),
                      ),
                    IconButton(onPressed:  () {_selectDate(context);},
                        color: Palette.primaryLightColor,
                        icon:const Icon(Icons.date_range),),],),
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
              controller: amount,
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
              ),
              validator: (value) {
                    if (value == null || value.isEmpty) {
                            return 'This field should not be empty';
                    }}
            ),),
            Text("DH", style: TextStyle(
              color: Palette.primaryLightColor,
              fontSize: 40,
              fontWeight: FontWeight.w700,),),
          ],
        ),
       ),),
       SizedBox(height: 60),
            ElevatedButton(onPressed: () 
              async{
                if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc(clientid).collection("Transactions").doc().set({
                  "date": _date,
                  "amount":amount.text,
                  "isSalaf":true
                });
                DocumentSnapshot variable = await FirebaseFirestore.instance.collection("Users").doc(userid).collection("Clients").doc(clientid).get();
                var initialamount =variable['amount'];
                var total  =int.parse(initialamount) + int.parse(amount.text);

                await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc(clientid).update({
                  "amount":total.toString(),
                });
                int entree =0;
                int sortie =0;

                QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').doc(userid).collection('Clients').get();
                final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
                setState(() {
                  for (var client in allData) {
                    if((client as Map)["isSalaf"] ==true) sortie+=int.parse((client as Map)["amount"]) ;
                    else entree+=int.parse((client as Map)["amount"]) ;

                  }
                });

                await FirebaseFirestore.instance.collection("Users").doc(userid).update({
                  "entrée":entree,
                  "sortie" :sortie
                });
                Navigator.pop(context);
                } },
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
                   Navigator.pop(context);}, 
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
      ],),),), );
     
  }
}