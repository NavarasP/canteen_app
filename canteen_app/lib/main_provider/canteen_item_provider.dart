// main_provider/canteen_item_provider.dart

import 'package:flutter/material.dart';
import 'package:canteen_app/models/canteen_item.dart';

class CanteenItemProvider extends ChangeNotifier {
  List<CanteenItem> _canteenItems = [];

  List<CanteenItem> get canteenItems => _canteenItems;

  void setCanteenItems(List<CanteenItem> items) {
    _canteenItems = items;
    notifyListeners();
  }
}
