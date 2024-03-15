import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Services/api_models/agent_model.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';


class DeliveryAgentService {
  // final String baseUrl = 'http://127.0.0.1:8000';
    final String baseUrl = 'http://192.168.1.4:8000';


  Future<List<OrderItemAgent>> getOrderListForDeliveryAgent() async {
    try {
      final authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/delivery/order/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];

        return responseData.map((data) => OrderItemAgent.fromJson(data)).toList();
      } else {
        debugPrint('Error fetching order list: ${response.statusCode}');
        throw Exception('Failed to fetch order list');
      }
    } catch (e) {
      debugPrint('Error fetching order list: $e');
      rethrow;
    }
  }

Future<void> updateOrderStatusPicked(String orderId) async {
  try {
    final String? authToken = await AuthenticationService.getAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/delivery/order/status/picked/$orderId/'),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },

    );

    if (response.statusCode != 200) {
      debugPrint('Error updating order status to picked: ${response.statusCode}');
      throw Exception('Failed to update order status to picked');
    }
  } catch (e) {
    debugPrint('Error updating order status to picked: $e');
    rethrow;
  }
}


  Future<void> updateOrderStatusDelivered(String orderId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/delivery/order/status/delivered/$orderId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },

      );

      if (response.statusCode != 200) {
        debugPrint('Error updating order status to delivered: ${response.statusCode}');
        throw Exception('Failed to update order status to delivered');
      }
    } catch (e) {
      debugPrint('Error updating order status to delivered: $e');
      rethrow;
    }
  }
}
