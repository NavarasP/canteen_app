import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Services/Models/manager_model.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';

class CanteenServiceManager {
  final String baseUrl = 'http://127.0.0.1:8000';
    // final String baseUrl = 'https://fn5bbnp1-8000.inc1.devtunnels.ms';


  Future<List<CanteenItemManager>> getFoodListManager() async {
    try {
      final authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/canteen/food/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> itemsData = responseData['data'];

        return itemsData
            .map((data) => CanteenItemManager.fromJson(data))
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

  Future<void> createFood(Map<String, dynamic> foodData) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/canteen/food/create/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
        body: foodData,
      );

      if (response.statusCode == 200) {
        debugPrint('Food created successfully!');
      } else {
        debugPrint('Error creating food: ${response.statusCode}');
        throw Exception('Failed to create food');
      }
    } catch (e) {
      debugPrint('Error creating food: $e');
      rethrow;
    }
  }

  Future<void> updateFood(int foodId, Map<String, dynamic> foodData) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/canteen/food/update/$foodId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
        body: foodData,
      );

      if (response.statusCode == 200) {
        debugPrint('Food updated successfully!');
      } else {
        debugPrint('Error updating food: ${response.statusCode}');
        throw Exception('Failed to update food');
      }
    } catch (e) {
      debugPrint('Error updating food: $e');
      rethrow;
    }
  }

  Future<void> deleteFood(int foodId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/canteen/food/delete/$foodId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Food deleted successfully!');
      } else {
        debugPrint('Error deleting food: ${response.statusCode}');
        throw Exception('Failed to delete food');
      }
    } catch (e) {
      debugPrint('Error deleting food: $e');
      rethrow;
    }
  }

  Future<FoodDetailManager> getFoodDetailManager(int foodId) async {
  try {
    final String? authToken = await AuthenticationService.getAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/canteen/food/detail/$foodId/'),
      headers: {
        'Authorization': 'Token $authToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'];
      return FoodDetailManager.fromJson(responseData);
    } else {
      debugPrint('Error fetching food detail: ${response.statusCode}');
      throw Exception('Failed to fetch food detail');
    }
  } catch (e) {
    debugPrint('Error fetching food detail: $e');
    rethrow;
  }
}


  Future<void> markAsTodaysSpecial(int foodId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/canteen/food/mark-as-todays-special/$foodId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Food marked as today\'s special successfully!');
      } else {
        debugPrint('Error marking food as today\'s special: ${response.statusCode}');
        throw Exception('Failed to mark food as today\'s special');
      }
    } catch (e) {
      debugPrint('Error marking food as today\'s special: $e');
      rethrow;
    }
  }

  Future<List<OrderStatusDropdown>> getOrderStatusDropdown() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/canteen/order/status/dropdown/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        return responseData.map((data) => OrderStatusDropdown.fromJson(data)).toList();
      } else {
        debugPrint('Error fetching order status dropdown: ${response.statusCode}');
        throw Exception('Failed to fetch order status dropdown');
      }
    } catch (e) {
      debugPrint('Error fetching order status dropdown: $e');
      rethrow;
    }
  }

  Future<OrderStatusChangeResponse> changeOrderStatus(String orderId, String status, String remarks) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();
      final Map<String, dynamic> requestData = {
        'status': status,
        'remarks': remarks,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/canteen/order/status/change/$orderId/'),
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return OrderStatusChangeResponse.fromJson(responseData);
      } else {
        debugPrint('Error changing order status: ${response.statusCode}');
        throw Exception('Failed to change order status');
      }
    } catch (e) {
      debugPrint('Error changing order status: $e');
      rethrow;
    }
  }

  Future<List<OrderListManager>> getOrderListManager() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/canteen/order/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        return responseData.map((data) => OrderListManager.fromJson(data)).toList();
      } else {
        debugPrint('Error fetching order list: ${response.statusCode}');
        throw Exception('Failed to fetch order list');
      }
    } catch (e) {
      debugPrint('Error fetching order list: $e');
      rethrow;
    }
  }

  Future<OrderDetailManager> getOrderDetailManager(String orderId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/canteen/order/detail/$orderId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        return OrderDetailManager.fromJson(responseData);
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
