import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/services/Models/users_models.dart';
import 'package:canteen_app/services/api/authentication_service.dart';

class CanteenServiceUser {
  final String baseUrl = 'http://127.0.0.1:8000';
    // final String baseUrl = 'https://fn5bbnp1-8000.inc1.devtunnels.ms';


  Future<List<CanteenItemStudent>> getFoodListUser() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/student/food/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> itemsData = responseData['data'];

        return itemsData
            .map((data) => CanteenItemStudent.fromJson(data))
            .toList();
      } else {
        debugPrint('Error fetching food items: ${response.statusCode}');
        throw Exception('Failed to fetch food items');
      }
    } catch (e) {
      debugPrint('Error fetching food items: $e');
      rethrow;
    }
  }


  Future<void> placeOrder(List<Map<String, dynamic>> products, String deliveryTime) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/student/order/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
        body: {
          'products': jsonEncode(products),
          'delivery_time': deliveryTime,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Order placed successfully!');
      } else {
        debugPrint('Error placing order: ${response.statusCode}');
        throw Exception('Failed to place order');
      }
    } catch (e) {
      debugPrint('Error placing order: $e');
      rethrow;
    }
  }

  Future<List<Order>> getOrderListForStudent() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/student/order/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> ordersData = responseData['data'];

        return ordersData.map((data) => Order.fromJson(data)).toList();
      } else {
        debugPrint('Error fetching order list: ${response.statusCode}');
        throw Exception('Failed to fetch order list');
      }
    } catch (e) {
      debugPrint('Error fetching order list: $e');
      rethrow;
    }
  }

  Future<OrderDetail> getOrderDetailForStudent(String orderId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/student/order/detail/$orderId'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> orderData = responseData['data'];

        return OrderDetail.fromJson(orderData);
      } else {
        debugPrint('Error fetching order detail: ${response.statusCode}');
        throw Exception('Failed to fetch order detail');
      }
    } catch (e) {
      debugPrint('Error fetching order detail: $e');
      rethrow;
    }
  }


}
