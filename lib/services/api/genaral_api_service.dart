import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Services/api_models/general_model.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';

class GenralService {
  // final String baseUrl = 'http://127.0.0.1:8000';
  final String baseUrl = 'http://192.168.1.4:8000';


Future<List<FoodCategory>> getFoodCategories() async {
  try {
    final String? authToken = await AuthenticationService.getAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/canteen/food/category/dropdown/'),
      headers: {
        'Authorization': 'Token $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> categoriesData = responseData['data'];

      List<FoodCategory> categories = categoriesData
          .map((data) => FoodCategory.fromJson(data))
          .toList();

      return categories;
    } else {
      debugPrint('Error fetching food categories: ${response.statusCode}');
      throw Exception('Failed to fetch food categories');
    }
  } catch (e) {
    debugPrint('Error fetching food categories: $e');
    rethrow;
  }
}



  Future<List<Course>> getCourses() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/mobile/student/department/dropdown/'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> coursesData = responseData['data'];

        return coursesData.map((data) => Course.fromJson(data)).toList();
      } else {
        debugPrint('Error fetching courses: ${response.statusCode}');
        throw Exception('Failed to fetch courses');
      }
    } catch (e) {
      debugPrint('Error fetching courses: $e');
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> statusData = responseData['data'];


        return statusData.map((data) => OrderStatusDropdown.fromJson(data)).toList();
      } else {
        debugPrint(
            'Error fetching order status dropdown: ${response.statusCode}');
        throw Exception('Failed to fetch order status dropdown');
      }
    } catch (e) {
      debugPrint('Error fetching order status dropdown: $e');
      rethrow;
    }
  }
}
