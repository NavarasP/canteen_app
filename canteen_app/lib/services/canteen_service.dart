import 'package:canteen_app/models/canteen_item.dart';

class CanteenService {
  // Placeholder list to store canteen items (Replace this with your data storage solution)
  List<CanteenItem> _canteenItems = [];

  // Method to add a new item to the canteen
  void addItem({required String name, required double price, required int quantity}) {
    CanteenItem newItem = CanteenItem(
      id: _canteenItems.length + 1,
      name: name,
      price: price,
      quantity: quantity,
      isApproved: false,
      approvedBy: "",
      isTodaysSpecial: false,
    );

    _canteenItems.add(newItem);

    // Additional logic to persist the data, e.g., save to a database or update the backend
  }

  // Method to fetch all canteen items
  List<CanteenItem> getAllItems() {
    return _canteenItems;
  }

  // Additional methods for updating, approving, or fetching specific canteen items can be added here
}
