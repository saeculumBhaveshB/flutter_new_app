import 'package:cloud_firestore/cloud_firestore.dart';

class ConstValues {
  final num oil;
  final num power;
  final num tree;
  final num waste;
  final num water;

  const ConstValues(
      {required this.oil,
      required this.power,
      required this.tree,
      required this.waste,
      required this.water});

  static ConstValues fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ConstValues(
      oil: snapshot["oil"],
      power: snapshot["power"],
      tree: snapshot["tree"],
      waste: snapshot["waste"],
      water: snapshot["water"],
    );
  }

  Map<String, num> toJson() => {
        "oil": oil,
        "power": power,
        "tree": tree,
        "water": water,
        "waste": waste
      };
}
