import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String phoneNumber;
  final String uid;
  final String name;
  final double totalClothWeight;
  final String upiID;
  const User(
      {required this.name,
      required this.uid,
      required this.phoneNumber,
      this.totalClothWeight = 0,
      this.upiID = ""});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        name: snapshot["name"],
        uid: snapshot["uid"],
        phoneNumber: snapshot["phoneNumber"],
        totalClothWeight: snapshot["totalClothWeight"],
        upiID: snapshot["upiID"]);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "phoneNumber": phoneNumber,
        "totalClothWeight": totalClothWeight,
        "upiID": upiID
      };
}
