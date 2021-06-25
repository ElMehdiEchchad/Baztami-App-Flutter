part of 'currentuser_bloc.dart';

abstract class CurrentuserEvent extends Equatable {
  const CurrentuserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends CurrentuserEvent {}

class UpdateUser extends CurrentuserEvent {
  final CurrentUser currentUser;
  const UpdateUser(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}

// class DeleteWalletTransactions extends WalletEvent {
//   final WalletTransaction walletTransaction;CurrentuserEvent
//   const DeleteWalletTransactions(this.walletTransaction);
//   @override
//   List<Object> get props => [walletTransaction];
// }

class UserUpdated extends CurrentuserEvent {
  final CurrentUser currentUser;
  const UserUpdated(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}
