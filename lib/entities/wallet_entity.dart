// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String id;
  final double amount;
  final String description;
  final bool isDepense;
  final Timestamp date;

  const WalletEntity(
      this.id, this.date, this.description, this.amount, this.isDepense);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'amount': amount,
      'isDepense': isDepense,
    };
  }

  @override
  List<Object> get props => [id, date, description, amount, isDepense];

  @override
  String toString() {
    return 'WalletTransactionEntity { id: $id, date: $date, description: $description, amount: $amount, isDepense: $isDepense }';
  }

  static WalletEntity fromJson(Map<String, Object> json) {
    return WalletEntity(
      json['id'] as String,
      json['date'] as Timestamp,
      json['description'] as String,
      json['amount'] as double,
      json['isDepense'] as bool,
    );
  }

  static WalletEntity fromSnapshot(DocumentSnapshot snap) {
    return WalletEntity(
      snap.id,
      snap['date'],
      snap['description'],
      snap['amount'],
      snap['isDepense'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      //'id': id,
      'date': date,
      'description': description,
      'amount': amount,
      'isDepense': isDepense,
    };
  }
}
