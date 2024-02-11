import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Models/inspector_models.dart';
import 'package:canteen_app/services/api/authentication_service.dart';

class CanteenServiceInspector {
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<List<CanteenItem_Inspector>> getFoodListInspector() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

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
            .map((data) => CanteenItem_Inspector.fromJson(data))
            .toList();
      } else {
        debugPrint('Error fetching food items: ${response.statusCode}');
        throw Exception('Failed to fetch food items');
      }
    } catch (e) {
      debugPrint('Error fetching food items: $e');
      throw e;
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
      throw e;
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
      throw e;
    }
  }
}
