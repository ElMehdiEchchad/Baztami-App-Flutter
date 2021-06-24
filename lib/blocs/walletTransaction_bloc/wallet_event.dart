part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object> get props => [];
}

class LoadWalletTransactions extends WalletEvent {}

class AddWalletTransactions extends WalletEvent {
  final WalletTransaction walletTransaction;
  const AddWalletTransactions(this.walletTransaction);
  @override
  List<Object> get props => [walletTransaction];
}

class UpdateWalletTransactions extends WalletEvent {
  final WalletTransaction walletTransaction;
  const UpdateWalletTransactions(this.walletTransaction);
  @override
  List<Object> get props => [walletTransaction];
}

class DeleteWalletTransactions extends WalletEvent {
  final WalletTransaction walletTransaction;
  const DeleteWalletTransactions(this.walletTransaction);
  @override
  List<Object> get props => [walletTransaction];
}

class WalletTransactionsUpdated extends WalletEvent {
  final List<WalletTransaction> walletTransactionList;
  const WalletTransactionsUpdated(this.walletTransactionList);
  @override
  List<Object> get props => [walletTransactionList];
}
