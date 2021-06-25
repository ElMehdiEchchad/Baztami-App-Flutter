// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:baztami_app_flutter/data/wallets_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/entities.dart';
import '../models/wallet_transaction.dart';

final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;

class FirebaseWalletTransactionsRepository
    implements WalletsTransactionsRepository {
  final walletCollection = FirebaseFirestore.instance
      .collection('Users')
      .doc(cuurentUserID)
      .collection("WalletBalance");

  @override
  Future<void> addNewWalletTransaction(WalletTransaction walletTransaction) {
    return walletCollection.add(walletTransaction.toEntity().toDocument());
  }

  @override
  Future<void> deleteWalletTransaction(
      WalletTransaction walletTransaction) async {
    return walletCollection.doc(walletTransaction.id).delete();
  }

  @override
  Stream<List<WalletTransaction>> walletTransactions() {
    return walletCollection
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              WalletTransaction.fromEntity(WalletEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateWalletTransaction(WalletTransaction update) {
    return walletCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
