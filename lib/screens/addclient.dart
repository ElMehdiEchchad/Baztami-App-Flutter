import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:baztami_app_flutter/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  PhoneNumber phoneNumber = PhoneNumber();
  List<String> _locations = ['Give','Take']; // Option 2
  String _selectedLocation ='Give'; // Option 2
  late String _date ='Select date ..';
  final String userid = FirebaseAuth.instance.currentUser!.uid ;
  final  userCollection = FirebaseFirestore.instance.collection("Users");
  TextEditingController name = new TextEditingController() ;
  TextEditingController amount = new TextEditingController() ;

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }

  Future _selectDate(BuildContext context) async {
    print("salma"+userid);
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
    return  new Scaffold(
      appBar: new AppBar(
        title: const Text('New client'),
        actions: [
          new FlatButton(
              onPressed: () async{
                await FirebaseFirestore.instance.collection('Users').doc(userid).collection("Clients").doc().set({
                  "date": _date,
                 
                });

              },
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead!
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: Container(
        child: Column(
          children: [

            Padding(padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Client name ..",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            controller: TextEditingController()..text = _date,
                            decoration: InputDecoration(
                              hintText: "Date ..",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                            ),

                          ),
                        ),
                      ),
                      IconButton(onPressed:  () {_selectDate(context);},
                        color: Palette.primaryLightColor,
                        icon:const Icon(Icons.date_range),),
                    ],
                  ),
                  SizedBox(height:30),

                  InternationalPhoneNumberInput(
                    countrySelectorScrollControlled: true,
                    initialValue: PhoneNumber(
                      isoCode: "MA",
                    ),
                    hintText: "Client number ...",
                    onInputChanged: (PhoneNumber value) =>
                        _handleInput(value),
                  ),
                  SizedBox(height:30 ,),
                 Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                         // width :40,
                          child: DropdownButton(
                            hint: Text('Transaction'),
                            // Not necessary for Option 1
                            value: _selectedLocation,
                            onChanged: (Value) {
                              setState(() {
                                _selectedLocation = Value.toString();
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                     SizedBox(
                       width: 10,
                     ),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextFormField(
                            controller: amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount ..",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                     /* Expanded(
                        child: Container(
                          height: 50,
                          child: TextFormField(

                          ),
                        ),
                      ),*/
                    ],
                 )
                ],),
            ),



          ],),
      )
    );
  }
}