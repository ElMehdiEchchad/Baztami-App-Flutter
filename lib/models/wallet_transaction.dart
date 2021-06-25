import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class WalletTransaction extends Equatable {
  final String id;
  final double amount;
  final String description;
  final bool isDepense;
  final Timestamp date;

  WalletTransaction(String id,
      {required this.date,
      required this.amount,
      required this.isDepense,
      required this.description})
      : id = id;

  WalletTransaction copyWith(
      {String? id,
      Timestamp? date,
      double? amount,
      bool? isDepense,
      String? description}) {
    return WalletTransaction(id ?? this.id,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        isDepense: isDepense ?? this.isDepense,
        description: description ?? this.description);
  }

  @override
  String toString() {
    return 'walletTransaction{id: $id, date: $date, description: $description, amount: $amount, isDepense: $isDepense}';
  }

  WalletEntity toEntity() {
    return WalletEntity(id, date, description, amount, isDepense);
  }

  static WalletTransaction fromEntity(WalletEntity entity) {
    return WalletTransaction(
      entity.id,
      date: entity.date,
      description: entity.description,
      amount: entity.amount,
      isDepense: entity.isDepense,
    );
  }

  @override
  List<Object> get props => [id, amount, description, isDepense, date];
}
