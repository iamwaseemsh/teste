import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModal {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
  String? weightInKg;
  DateTime date = DateTime.now();
  WeightModal(this.weightInKg);
  Map<String, dynamic> toMap(WeightModal weightModal) {
    Map<String, dynamic> weight = Map();
    weight["id"] = weightModal.id;
    weight["date"] = weightModal.date;
    weight["weightInKg"] = weightModal.weightInKg;

    return weight;
  }

  WeightModal.fromSnapshot(QueryDocumentSnapshot map) {
    this.id = map["id"];
    this.date = map["date"].toDate();
    this.weightInKg = map["weightInKg"];
  }
}
