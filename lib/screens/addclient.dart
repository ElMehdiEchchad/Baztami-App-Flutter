import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:numberpicker/numberpicker.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  PhoneNumber phoneNumber = PhoneNumber();
  List<String> _locations = ['Give','Take']; // Option 2
  String _selectedLocation ='Give'; // Option 2
  int _currentHorizontalIntValue = 50;
  late String _date ;

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019)
    );
    if(picked != null) setState(() => _date = picked.toString());
  }


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: const Text('New client'),
        actions: [
          new FlatButton(
              onPressed: () {
                //TODO: Handle save
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

            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 50,
                    child: TextFormField(
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

                  Container(
                    height: 50,
                    child: InkWell(
                      onTap: (){
                        // Below line stops keyboard from appearing

                        _selectDate();
                        // Show Date Picker Here

                      },
                      child: TextFormField(
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
                      NumberPicker(
                        value: _currentHorizontalIntValue,
                        minValue: 50,
                        maxValue: 10000,
                        step: 50,
                        itemHeight: 60,
                        axis: Axis.horizontal,
                        onChanged: (value) =>
                            setState(() => _currentHorizontalIntValue = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
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