import 'package:baztami_app_flutter/entities/entities.dart';
import 'package:baztami_app_flutter/models/models.dart';
import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  final String id;
  final num balanceGeneral;
  final num revenues;
  final num depenses;
  //final List<WalletTransaction> listOfWalletTransaction;
  // final List<Interet>

  CurrentUser({
    required this.id,
    required this.balanceGeneral,
    required this.revenues,
    required this.depenses,
    //required this.listOfWalletTransaction
  });

  CurrentUser copyWith({
    String? id,
    num? balanceTotal,
    num? revenues,
    num? depenses,
  }) {
    return CurrentUser(
      id: id ?? this.id,
      balanceGeneral: balanceTotal ?? this.balanceGeneral,
      revenues: revenues ?? this.revenues,
      depenses: depenses ?? this.depenses,
    );
  }

  @override
  String toString() {
    return 'CurrentUser{id: $id, balanceGeneral: $balanceGeneral, revenues: $revenues, depenses: $depenses ';
  }

  @override
  List<Object?> get props => [id, balanceGeneral, revenues, depenses];

  CurrentUserEntity toEntity() {
    return CurrentUserEntity(id, balanceGeneral, revenues, depenses);
  }

  static CurrentUser fromEntity(CurrentUserEntity entity) {
    return CurrentUser(
      id: entity.id,
      balanceGeneral: entity.balanceGeneral,
      revenues: entity.revenues,
      depenses: entity.depenses,
    );
  }
}
