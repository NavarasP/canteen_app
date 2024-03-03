import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:canteen_app/Models/general_models.dart';
import 'package:canteen_app/services/api/authentication_service.dart';

class GenralService {
  final String baseUrl = 'http://127.0.0.1:8000';
    // final String baseUrl = 'https://fn5bbnp1-8000.inc1.devtunnels.ms';


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

        return categoriesData
            .map((data) => FoodCategory.fromJson(data))
            .toList();
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
}
