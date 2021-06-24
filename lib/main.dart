import 'package:baztami_app_flutter/blocs/simple_bloc_observer.dart';
import 'package:baztami_app_flutter/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/walletTransaction_bloc/wallet_bloc.dart';
import 'data/firebase_wallets_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
        create: (context) {
          return WalletBloc(
            walletTransactionRepository: FirebaseWalletTransactionsRepository(),
          )..add(LoadWalletTransactions());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Baztami',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "BalooTammudu2",
          ),
          //home: NaVBottomBar(),
          home: AuthService().handleAuth(),
        ));
  }
}
