import 'package:baztami_app_flutter/models/models.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String balanceTotal;
  final String revenues;
  final String depenses;
  final List<WalletTransaction> listOfWalletTransaction;
  // final List<Interet>

  User(
      {required this.id,
      required this.balanceTotal,
      required this.revenues,
      required this.depenses,
      required this.listOfWalletTransaction});

  @override
  List<Object?> get props => throw UnimplementedError();
}
