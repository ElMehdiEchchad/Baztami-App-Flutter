import 'dart:async';

import 'package:baztami_app_flutter/data/wallets_repository.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletsTransactionsRepository _walletTransactionRepository;
  StreamSubscription? _walletTransactionSubscription;

  WalletBloc(
      {required WalletsTransactionsRepository walletTransactionRepository})
      : _walletTransactionRepository = walletTransactionRepository,
        super(WalletLoading());

  @override
  Stream<WalletState> mapEventToState(
    WalletEvent event,
  ) async* {
    if (event is LoadWalletTransactions) {
      yield* _mapLoadWalletTransactionsToState();
    } else if (event is AddWalletTransactions) {
      yield* _mapAddWalletTransactionsToState(event);
    } else if (event is UpdateWalletTransactions) {
      yield* _mapUpdateWalletTransactionsToState(event);
    } else if (event is DeleteWalletTransactions) {
      yield* _mapDeleteWalletTransactionsToState(event);
    } else if (event is WalletTransactionsUpdated) {
      yield* _mapWalletTransactionsUpdatedToState(event);
    }
  }

  Stream<WalletState> _mapLoadWalletTransactionsToState() async* {
    _walletTransactionSubscription?.cancel();
    _walletTransactionSubscription = _walletTransactionRepository
        .walletTransactions()
        .listen((event) => add(WalletTransactionsUpdated(event)));
  }

  Stream<WalletState> _mapAddWalletTransactionsToState(
      AddWalletTransactions event) async* {
    _walletTransactionRepository
        .addNewWalletTransaction(event.walletTransaction);
  }

  Stream<WalletState> _mapUpdateWalletTransactionsToState(
      UpdateWalletTransactions event) async* {
    _walletTransactionRepository
        .updateWalletTransaction(event.walletTransaction);
  }

  Stream<WalletState> _mapDeleteWalletTransactionsToState(
      DeleteWalletTransactions event) async* {
    _walletTransactionRepository
        .deleteWalletTransaction(event.walletTransaction);
  }

  Stream<WalletState> _mapWalletTransactionsUpdatedToState(
      WalletTransactionsUpdated event) async* {
    yield WalletLoaded(event.walletTransactionList);
  }

  @override
  Future<void> close() {
    _walletTransactionSubscription?.cancel();
    return super.close();
  }
}
