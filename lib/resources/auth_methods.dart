import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nokasa_user/models/user.dart' as model;
import 'package:nokasa_user/screen/auth/signin/signin.dart';
import 'package:nokasa_user/utils/navigation.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }
  String getuserId(){
    String userId=_auth.currentUser!.uid;
    return userId;
  }
  Future<String> loginUser({
    required String token,
  }) async {
    String res = "Some error Occurred";
    try {
      if (token.isNotEmpty) {
        await _auth.signInWithCustomToken(token);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> updateUserDetails({
    String? name,
    String? upiID,
    double? totalClothWeight,
    String? phoneNumber,
  }) async {
    String res = "Some error occurred";
    try {
      User currentUser = _auth.currentUser!;
      Map<String, dynamic> updateData = {};

      if (name != null){
        updateData['name'] = name;
      } 
      if (upiID != null) updateData['upiID'] = upiID;
      if (totalClothWeight != null) {
        updateData['totalClothWeight'] = totalClothWeight;
      }
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;

      if (updateData.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .update(updateData);
        res = "success";
      } else {
        res = "No fields to update";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    Navigation().emptyStack(context, SignIn());
  }
}


