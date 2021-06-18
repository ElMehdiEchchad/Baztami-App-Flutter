import 'package:baztami_app_flutter/config/config.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

class WalletHistoriqueScreen extends StatefulWidget with PreferredSizeWidget {
  final String date;
  final bool isDepense;
  final String description;
  final String amount;
  WalletHistoriqueScreen(
      {Key? key,
      required this.date,
      required this.isDepense,
      required this.description,
      required this.amount})
      : super(key: key);

  @override
  _WalletHistoriqueScreenState createState() =>
      _WalletHistoriqueScreenState(amount);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _WalletHistoriqueScreenState extends State<WalletHistoriqueScreen> {
  TextEditingController _controller = new TextEditingController();
  late TextEditingController _amountController =
      new TextEditingController(text: amount);
  bool _enabled = true;
  String amount;
  _WalletHistoriqueScreenState(this.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        centerTitle: true,
        title: Icon(
          widget.isDepense
              ? Icons.arrow_circle_up_rounded
              : Icons.arrow_circle_down_rounded,
          color: widget.isDepense ? Palette.redColor : Palette.greenColor,
          size: 30,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Palette.primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //-----------------------------------------------------------------------
              Text("${widget.date}", style: Styles.headingStyle),
              SizedBox(
                height: 10,
              ),
              //--------------------------------------------- Amount -------------------------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.isDepense ? "- " : "+ ",
                        style: TextStyle(
                            color: widget.isDepense
                                ? Palette.redColor
                                : Palette.greenColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      autotextFormField(),
                      Text(
                        " DH",
                        style: TextStyle(
                            color: widget.isDepense
                                ? Palette.redColor
                                : Palette.greenColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              //-----------------------------------------------------------------------
              Text("Description", style: Styles.headingStyle),
              //---------------------------------------------------
              SizedBox(
                height: 10,
              ),
              TextField(
                enabled: _enabled,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'donner une description pour se mémoriser',
                ),
              ),

              //-----------------------------------------------------------------------
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 50, 50),
                            primary: Palette.primaryLightColor),
                        onPressed: () {
                          if (_enabled) {
                            _handleSauvegarder();
                          } else {
                            _handleModifier();
                          }
                        },
                        child: Text(
                          _enabled ? 'sauvegarder' : 'Modifier',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 50, 50),
                            primary: Palette.redColor),
                        onPressed: () {
                          _handleSupprimer();
                        },
                        child: Text('Supprimer'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleSauvegarder() {
    this.setState(() {
      _enabled = !_enabled;
    });
  }

  _handleModifier() {
    this.setState(() {
      _enabled = !_enabled;
    });
  }

  _handleSupprimer() {}

  AutoSizeTextField autotextFormField() {
    return AutoSizeTextField(
      onChanged: (value) => {
        this.setState(() {
          amount = value;
        })
      },
      minWidth: null,
      enabled: _enabled,
      fullwidth: false,
      keyboardType: TextInputType.number,
      controller: _amountController,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      style: TextStyle(
          color: widget.isDepense ? Palette.redColor : Palette.greenColor,
          fontSize: 40.0,
          fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }
}
