import 'package:baztami_app_flutter/blocs/walletTransaction_bloc/wallet_bloc.dart';
import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WalletHistoriqueScreen extends StatefulWidget with PreferredSizeWidget {
  // final String date;
  // final bool isDepense;
  // String? description;
  // final String amount;
  // String? historiqueID;
  final WalletTransaction walletTransaction;
  final bool isHistorique;
  WalletHistoriqueScreen(
      {Key? key,
      // required this.date,
      // required this.isDepense,
      // this.description,
      // required this.amount,
      // this.historiqueID
      required this.isHistorique,
      required this.walletTransaction})
      : super(key: key);

  @override
  _WalletHistoriqueScreenState createState() => _WalletHistoriqueScreenState(
      // date: this.date,
      // amount: this.amount,
      // description: this.description,
      // historiqueID: this.historiqueID,
      // isDepense: this.isDepense
      isHistorique: isHistorique,
      walletTransaction: walletTransaction);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _WalletHistoriqueScreenState extends State<WalletHistoriqueScreen> {
  late TextEditingController _controller;
  late TextEditingController _amountController;

  final WalletTransaction walletTransaction;

  late bool _enabled;
  final bool isHistorique;

  //----------------------------------
  String? amount;
  String? description;
  String? date;
  String? historiqueID;
  bool? isDepense;
  //----------------------------------

  _WalletHistoriqueScreenState(
      {required this.walletTransaction, required this.isHistorique}) {
    _enabled = this.isHistorique ? false : true;
    _controller =
        new TextEditingController(text: this.walletTransaction.description);
    _amountController =
        new TextEditingController(text: this.walletTransaction.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        centerTitle: true,
        title: Icon(
          //widget.isDepense
          walletTransaction.isDepense
              ? Icons.arrow_circle_up_rounded
              : Icons.arrow_circle_down_rounded,
          color: walletTransaction.isDepense
              ? Palette.redColor
              : Palette.greenColor,
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

              Text(
                  DateFormat("dd-MM-yyyy")
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          walletTransaction.date.seconds * 1000))
                      .toString(),
                  style: Styles.headingStyle),
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
                        walletTransaction.isDepense ? "- " : "+ ",
                        style: TextStyle(
                            color: walletTransaction.isDepense
                                ? Palette.redColor
                                : Palette.greenColor,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      autotextFormField(),
                      Text(
                        " DH",
                        style: TextStyle(
                            color: walletTransaction.isDepense
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
                            _handleSauvegarder(context);
                            // BlocProvider.of<WalletBloc>(context).add(
                            //     AddWalletTransactions(new WalletTransaction(
                            //         amount: "30",
                            //         date: Timestamp.fromDate(DateTime.now()),
                            //         isDepense: true,
                            //         description: "test tes a supprimer",
                            //         id: 'hhhhhhhhhhhhhhhh')));
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
                      isHistorique == true
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width - 50,
                                      50),
                                  primary: Palette.redColor),
                              onPressed: () {
                                _handleSupprimer();
                              },
                              child: Text('Supprimer'),
                            )
                          : Container(),
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

  _handleSauvegarder(BuildContext context) async {
    this.setState(() {
      _enabled = !_enabled;
    });
    BlocProvider.of<WalletBloc>(context).add(isHistorique == false
        ? AddWalletTransactions(walletTransaction.copyWith(
            amount: amount, description: _controller.text))
        : UpdateWalletTransactions(walletTransaction.copyWith(
                amount: amount, description: _controller.text)
            // )
            ));
    Navigator.of(context).pop();
  }

  _handleModifier() {
    this.setState(() {
      _enabled = !_enabled;
    });
  }

  _handleSupprimer() {
    BlocProvider.of<WalletBloc>(context)
        .add(DeleteWalletTransactions(walletTransaction));
    Navigator.of(context).pop();
  }

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
          color: walletTransaction.isDepense
              ? Palette.redColor
              : Palette.greenColor,
          fontSize: 40.0,
          fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }
}
