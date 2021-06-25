import 'package:baztami_app_flutter/models/models.dart';

abstract class UserRepository {
  Stream<CurrentUser> user();

  Future<void> updateUser(CurrentUser user);
}
