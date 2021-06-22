import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  PhoneNumber phoneNumber = PhoneNumber();

  _handleInput(PhoneNumber value) {
    setState(() {
      phoneNumber = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
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
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      "Add a client",
                      style: TextStyle(
                        color: Palette.primaryLightColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("  NOM",
                    style: TextStyle(color: Palette.primaryLightColor),
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0)),
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
                    hintText: "Enter votre num...",
                    onInputChanged: (PhoneNumber value) =>
                        _handleInput(value),
                  ),
                  SizedBox(height:30),
                  Text(" Type", style:
                  TextStyle(color: Palette.primaryLightColor),
                  ),

                  Container(
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0))
                        ),
                      ),
                    ),
                  )
                ],),
            ),
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

          ],),
      )
    );
  }
}