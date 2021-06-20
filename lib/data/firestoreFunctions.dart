import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreFunctions {
  String cuurentUserID = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Object?>> getWalletHistory(String uid) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .collection("WalletBlance")
        .snapshots();
  }

  Future<dynamic> getWalletHistoryById(String uid) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(cuurentUserID)
        .collection("WalletBlance")
        .doc(uid)
        .snapshots();
  }
}
