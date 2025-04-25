import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String phoneNumber;
  final String uid;
  final String name;
  final String upiID;
  final num totalClothWeight;

  const User(
      {required this.phoneNumber,
      required this.uid,
      required this.name,
      this.upiID = "",
      this.totalClothWeight = 0});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      phoneNumber: snapshot["phoneNumber"],
      uid: snapshot["uid"],
      name: snapshot["name"],
      upiID: snapshot["upiID"],
      totalClothWeight: snapshot["totalClothWeight"],
    );
  }

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "uid": uid,
        "name": name,
        "totalClothWeight": totalClothWeight,
        "upiID": upiID
      };
}
