import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CurrentUserEntity extends Equatable {
  final String id;
  final num balanceGeneral;
  final num revenues;
  final num depenses;
  const CurrentUserEntity(
      this.id, this.balanceGeneral, this.revenues, this.depenses);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'balanceGeneral': balanceGeneral,
      'revenues': revenues,
      'depenses': depenses,
    };
  }

  @override
  List<Object> get props => [id, balanceGeneral, revenues, depenses];

  @override
  String toString() {
    return 'CurrentUserEntity{id: $id, balanceGeneral: $balanceGeneral, revenues: $revenues, depenses: $depenses ';
  }

  static CurrentUserEntity fromJson(Map<String, Object> json) {
    return CurrentUserEntity(
      json['id'] as String,
      json['balanceGeneral'] as num,
      json['revenues'] as num,
      json['depenses'] as num,
    );
  }

  static CurrentUserEntity fromSnapshot(DocumentSnapshot snap) {
    return CurrentUserEntity(
      snap.id,
      snap['BalanceGeneral'],
      snap['Revenues'],
      snap['Depenses'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      //'id': id,
      'BalanceGeneral': balanceGeneral,
      'Revenues': revenues,
      'Depenses': depenses,
    };
  }
}
