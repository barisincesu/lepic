import 'package:lepic/models/group.dart';
import 'package:lepic/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GroupProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _price;
  String _productId;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get price => _price;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  loadValues(Group group) {
    _name = group.name;
    _price = group.price;
    _productId = group.productId;
  }

  saveGroup() {
    print(_productId);
    if (_productId == null) {
      var newGroup = Group(name: name, price: price, productId: uuid.v4());
      firestoreService.saveGroup(newGroup);
    } else {
      //Update
      var updatedGroup =
          Group(name: name, price: _price, productId: _productId);
      firestoreService.saveGroup(updatedGroup);
    }
  }

  removeGroup(String productId) {
    firestoreService.removeGroup(productId);
  }
}
