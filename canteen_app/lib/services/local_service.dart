import 'dart:convert';
import 'package:canteen_app/Models/users_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String cartItemsKey = 'cartItems';

  static Future<List<CartItem>> loadCartItems() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String cartItemsJson = prefs.getString(cartItemsKey) ?? '[]';
      final List<dynamic> cartItemsData = json.decode(cartItemsJson);

      // Convert the data to CartItem objects
      return cartItemsData.map((data) => CartItem.fromJson(data)).toList();
    } catch (e) {
      print('Error loading cart items: $e');
      return [];
    }
  }

static Future<void> saveCartItems(List<CartItem> cartItems) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of cart items to JSON
    final List<Map<String, dynamic>> cartItemsJsonList = cartItems.map((item) {
      return {
        'itemName': item.itemName,
        'itemPrice': item.itemPrice,
        'quantity': item.quantity,
      };
    }).toList();

    final String cartItemsJson = json.encode(cartItemsJsonList);

    // Save the JSON string to shared preferences
    prefs.setString(cartItemsKey, cartItemsJson);
  } catch (e) {
    print('Error saving cart items: $e');
  }
}

  static Future<void> updateCartItems(List<CartItem> cartItems) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Convert the list of cart items to JSON
      final List<Map<String, dynamic>> cartItemsJsonList =
          cartItems.map((item) {
        return {
          'itemName': item.itemName,
          'itemPrice': item.itemPrice,
          'quantity': item.quantity,
        };
      }).toList();

      final String cartItemsJson = json.encode(cartItemsJsonList);

      // Save the JSON string to shared preferences
      prefs.setString(cartItemsKey, cartItemsJson);
    } catch (e) {
      print('Error saving cart items: $e');
    }
  }


  static Future<void> clearCart() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Clear the cart items from shared preferences
      prefs.remove(cartItemsKey);
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

}
