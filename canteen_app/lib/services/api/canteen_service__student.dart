import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:canteen_app/Models/users_models.dart';
import 'package:canteen_app/services/api/authentication_service.dart';

class CanteenService_User {
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<List<CanteenItem_Student>> getFoodList_user() async {
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
            .map((data) => CanteenItem_Student.fromJson(data))
            .toList();
      } else {
        print('Error fetching food items: ${response.statusCode}');
        throw Exception('Failed to fetch food items');
      }
    } catch (e) {
      print('Error fetching food items: $e');
      throw e;
    }
  }
}
