import 'dart:convert';
import 'variable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';
import 'package:canteen_app/Services/api_models/inspector_model.dart';


class CanteenServiceInspector {
 


  Future<List<CanteenItemInspector>> getFoodListInspector() async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$PrimeUrl/api/mobile/teacher/food/list/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> itemsData = responseData['data'];

        return itemsData
            .map((data) => CanteenItemInspector.fromJson(data))
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

  Future<CanteenItemDetailInspector> getFoodDetail(int foodId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$PrimeUrl/api/mobile/teacher/food/detail/$foodId'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> foodData = responseData['data'];

        return CanteenItemDetailInspector.fromJson(foodData);
      } else {
        debugPrint('Error fetching food detail: ${response.statusCode}');
        throw Exception('Failed to fetch food detail');
      }
    } catch (e) {
      debugPrint('Error fetching food detail: $e');
      rethrow;
    }
  }

  Future<void> approveFood(int foodId) async {
    try {
      final String? authToken = await AuthenticationService.getAuthToken();

      final response = await http.get(
        Uri.parse('$PrimeUrl/api/mobile/teacher/food/approve/$foodId/'),
        headers: {
          'Authorization': 'Token $authToken',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Food approved successfully!');
      } else {
        debugPrint('Error approving food: ${response.statusCode}');
        throw Exception('Failed to approve food');
      }
    } catch (e) {
      debugPrint('Error approving food: $e');
      rethrow;
    }
  }
}
