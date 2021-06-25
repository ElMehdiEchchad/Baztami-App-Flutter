part of 'currentuser_bloc.dart';

abstract class CurrentuserState extends Equatable {
  const CurrentuserState();

  @override
  List<Object> get props => [];
}

class CurrentUserLoading extends CurrentuserState {}

class CurrentUserLoaded extends CurrentuserState {
  final CurrentUser currentUser;
  //CurrentUser(balanceTotal: '', depenses: '', id: '', revenues: '')
  CurrentUserLoaded(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}

class CurrentUserFailed extends CurrentuserState {}
