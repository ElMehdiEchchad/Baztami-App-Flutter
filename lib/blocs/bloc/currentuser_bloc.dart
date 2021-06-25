import 'dart:async';

import 'package:baztami_app_flutter/data/user_repository.dart';
import 'package:baztami_app_flutter/models/current_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'currentuser_event.dart';
part 'currentuser_state.dart';

class CurrentuserBloc extends Bloc<CurrentuserEvent, CurrentuserState> {
  CurrentuserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(CurrentUserLoading());

  final UserRepository _userRepository;
  StreamSubscription? _wuserRepositorySubscription;

  @override
  Stream<CurrentuserState> mapEventToState(
    CurrentuserEvent event,
  ) async* {
    if (event is LoadUser) {
      yield* _mapLoadLoadToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is UserUpdated) {
      yield* _mapUserUpdatedToState(event);
    }
  }

  Stream<CurrentuserState> _mapLoadLoadToState() async* {
    _wuserRepositorySubscription?.cancel();
    _wuserRepositorySubscription =
        _userRepository.user().listen((event) => add(UserUpdated(event)));
  }

  Stream<CurrentuserState> _mapUpdateUserToState(UpdateUser event) async* {
    _userRepository.updateUser(event.currentUser);
  }

  Stream<CurrentuserState> _mapUserUpdatedToState(UserUpdated event) async* {
    yield CurrentUserLoaded(event.currentUser);
  }

  @override
  Future<void> close() {
    _wuserRepositorySubscription?.cancel();
    return super.close();
  }
}
