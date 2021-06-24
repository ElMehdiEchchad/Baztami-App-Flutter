// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import '../models/wallet_transaction.dart';

abstract class WalletsTransactionsRepository {
  Future<void> addNewWalletTransaction(WalletTransaction walletTransaction);

  Future<void> deleteWalletTransaction(WalletTransaction walletTransaction);

  Stream<List<WalletTransaction>> walletTransactions();

  Future<void> updateWalletTransaction(WalletTransaction walletTransaction);
}
