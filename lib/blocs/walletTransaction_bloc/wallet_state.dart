part of 'wallet_bloc.dart';

@immutable
abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final List<WalletTransaction> walletTransaction;

  const WalletLoaded([this.walletTransaction = const []]);

  @override
  List<Object> get props => [walletTransaction];
}

class WalletNotLoaded extends WalletState {}
