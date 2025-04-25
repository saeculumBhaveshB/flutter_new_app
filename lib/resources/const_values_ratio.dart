import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nokasa_user/models/const_values.dart' as model;

class ConstValuesRatio {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.ConstValues> getValues() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('constValues').doc("ratio").get();

    return model.ConstValues.fromSnap(documentSnapshot);
  }
}
