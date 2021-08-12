import 'package:flutter/material.dart';
import 'package:weight_app/modals/weight.dart';
import 'package:weight_app/resources/firebase_methods.dart';
import 'package:weight_app/utils/services.dart';

class DataProvider extends ChangeNotifier {
  List<WeightModal> _itemsList = [];
  List<WeightModal> get list => _itemsList;

  getAllItems() async {
    _itemsList = [];
    final items = await FirebaseMethods.getAllItems();
    for (var item in items.docs) {
      _itemsList.insert(0, WeightModal.fromSnapshot(item));
    }
    notifyListeners();
  }

  addItemToList(WeightModal weightModal) async {
    await FirebaseMethods.addItemToDB(weightModal);
    _itemsList.insert(0, weightModal);
    notifyListeners();
  }

  upDateAnItem(id, String weight) async {
    int loc = _itemsList.indexWhere((element) => element.id == id);
    await FirebaseMethods.updateWeight(id, weight);
    _itemsList[loc].weightInKg = weight;
    notifyListeners();
  }

  deleteAnItem(String id, BuildContext context) async {
    await FirebaseMethods.delete(id);
    CustomServices.showSnackBar(context, 'Item deleted');
    Navigator.of(context).pop();
    _itemsList = _itemsList.where((element) => element.id != id).toList();
    notifyListeners();
  }
}
