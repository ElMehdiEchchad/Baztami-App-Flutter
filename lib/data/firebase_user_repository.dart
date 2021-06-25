import 'package:baztami_app_flutter/data/user_repository.dart';
import 'package:baztami_app_flutter/entities/entities.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;

class FirebaseUserRepository implements UserRepository {
  final userDocument =
      FirebaseFirestore.instance.collection('Users').doc(cuurentUserID);

  @override
  Future<void> updateUser(CurrentUser user) {
    return userDocument.update(user.toEntity().toDocument());
  }

  @override
  Stream<CurrentUser> user() {
    return userDocument.snapshots().map((snapshot) {
      return CurrentUser.fromEntity(CurrentUserEntity.fromSnapshot(snapshot));
    });
  }
}
