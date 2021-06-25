import 'package:baztami_app_flutter/blocs/bloc/currentuser_bloc.dart';
import 'package:baztami_app_flutter/blocs/walletTransaction_bloc/wallet_bloc.dart';
import 'package:baztami_app_flutter/config/config.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WalletHistoriqueScreen extends StatefulWidget with PreferredSizeWidget {
  final WalletTransaction walletTransaction;
  final bool isHistorique;
  WalletHistoriqueScreen(
      {Key? key, required this.isHistorique, required this.walletTransaction})
      : super(key: key);

  @override
  _WalletHistoriqueScreenState createState() => _WalletHistoriqueScreenState(
      isHistorique: isHistorique, walletTransaction: walletTransaction);

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
  late double amount;
  late double previousAmount;
  //----------------------------------

  _WalletHistoriqueScreenState(
      {required this.walletTransaction, required this.isHistorique}) {
    _enabled = this.isHistorique ? false : true;
    _controller =
        new TextEditingController(text: this.walletTransaction.description);
    amount = this.walletTransaction.amount;
    _amountController = new TextEditingController(
        text: this.walletTransaction.amount.toString());
    previousAmount = this.walletTransaction.amount;
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final state = BlocProvider.of<CurrentuserBloc>(context).state;
      if (state is CurrentUserLoaded) {
        currentUser = state.currentUser;
      }
    });
  }

  late CurrentUser currentUser;

  _handleSauvegarder(BuildContext context) async {
    this.setState(() {
      _enabled = !_enabled;
    });
    if (isHistorique == true) {
      BlocProvider.of<WalletBloc>(context).add(UpdateWalletTransactions(
          walletTransaction.copyWith(
              amount: amount, description: _controller.text)));
      //traitment when update number
      if (previousAmount != amount) {
        BlocProvider.of<CurrentuserBloc>(context).add(
          UpdateUser(
            walletTransaction.isDepense
                ? CurrentUser(
                    balanceGeneral: currentUser.balanceGeneral -
                        num.parse(
                          amount.toString(),
                        ) +
                        previousAmount,
                    depenses: currentUser.depenses +
                        num.parse(
                          amount.toString(),
                        ) -
                        previousAmount,
                    id: "",
                    revenues: currentUser.revenues)
                : CurrentUser(
                    balanceGeneral: currentUser.balanceGeneral +
                        num.parse(
                          amount.toString(),
                        ) -
                        previousAmount,
                    depenses: currentUser.depenses,
                    id: "",
                    revenues: currentUser.revenues +
                        num.parse(
                          amount.toString(),
                        ) -
                        previousAmount,
                  ),
          ),
        );
      }
    } else {
      BlocProvider.of<WalletBloc>(context).add(AddWalletTransactions(
          walletTransaction.copyWith(
              amount: amount, description: _controller.text)));
      BlocProvider.of<CurrentuserBloc>(context).add(
        UpdateUser(
          walletTransaction.isDepense
              ? CurrentUser(
                  balanceGeneral: currentUser.balanceGeneral -
                      num.parse(
                        amount.toString(),
                      ),
                  depenses: currentUser.depenses +
                      num.parse(
                        amount.toString(),
                      ),
                  id: "",
                  revenues: currentUser.revenues)
              : CurrentUser(
                  balanceGeneral: currentUser.balanceGeneral +
                      num.parse(
                        amount.toString(),
                      ),
                  depenses: currentUser.depenses,
                  id: "",
                  revenues: currentUser.revenues +
                      num.parse(
                        amount.toString(),
                      ),
                ),
        ),
      );
    }

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
    BlocProvider.of<CurrentuserBloc>(context).add(UpdateUser(
      walletTransaction.isDepense
          ? CurrentUser(
              balanceGeneral: currentUser.balanceGeneral +
                  num.parse(
                    amount.toString(),
                  ),
              depenses: currentUser.depenses -
                  num.parse(
                    amount.toString(),
                  ),
              id: "",
              revenues: currentUser.revenues)
          : CurrentUser(
              balanceGeneral: currentUser.balanceGeneral -
                  num.parse(
                    amount.toString(),
                  ),
              depenses: currentUser.depenses,
              id: "",
              revenues: currentUser.revenues -
                  num.parse(
                    amount.toString(),
                  ),
            ),
    ));

    Navigator.of(context).pop();
  }

  AutoSizeTextField autotextFormField() {
    return AutoSizeTextField(
      onChanged: (value) => {
        this.setState(() {
          amount = double.parse(value);
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
