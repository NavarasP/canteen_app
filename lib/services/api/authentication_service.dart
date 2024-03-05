import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000';
  // final String baseUrl = 'https://fn5bbnp1-8000.inc1.devtunnels.ms';

  static const String authTokenKey = 'authToken';

  Future<void> saveUserDetails(
    String token, String email, String role, String agentId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('authToken', token);
  prefs.setString('email', email);
  prefs.setString('role', role);
  prefs.setString('agentId', agentId);
}


  static Future<Map<String, String?>> getUserDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return {
    'authToken': prefs.getString('authToken'),
    'email': prefs.getString('email'),
    'role': prefs.getString('role'),
    'agentId': prefs.getString('agentId'),
  };
}


  // Retrieve the auth token from SharedPreferences
  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  // Method to check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final String? authToken = await getAuthToken();
    return authToken != null;
  }

  Future<void> signIn(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/login/'),
      body: {'username': email, 'password': password},
    );

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the token and other user details from the response
      final String token = responseData['token'];
      final Map<String, dynamic> userData = responseData['data'];
      final String role = userData['role'];
      final String agentId = userData['agent']; // Assuming agentId is returned

      // Save user details
      await saveUserDetails(token, email, role, agentId);

      debugPrint('Signed in successfully!');
    } else {
      debugPrint('Error signing in: ${response.statusCode}');
      // Handle sign-in errors here
    }
  } catch (e) {
    debugPrint('Error signing in: $e');
    // Handle sign-in errors here
    rethrow; // Rethrow the exception for the caller to handle
  }
}


  Future<void> signOut() async {
    try {
      // Retrieve the auth token from SharedPreferences
      final String? authToken = await getAuthToken();

      // Clear the auth token from SharedPreferences
      // Passing empty strings for user details

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/logout/'),
        headers: {
          'Authorization':
              'Token $authToken', // Include the auth token in the headers
        },
        // Additional headers or data if needed
      );

      if (response.statusCode == 200) {
        await saveUserDetails('', '', '', '');
        debugPrint('Signed out successfully!');
      } else {
        debugPrint('Error signing out: ${response.statusCode}');
        // Handle sign-out errors here
      }
    } catch (e) {
      debugPrint('Error signing out: $e');
      // Handle sign-out errors here
      rethrow; // Rethrow the exception for the caller to handle
    }
  }

  Future<void> signUp(String mobile, String name, String password,
      String confirmPwd, String department) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/student/register/'),
        body: {
          'mobile': mobile,
          'name': name,
          'password': password,
          'confirm_password': confirmPwd,
          'department': department,
        },
      );

      if (response.statusCode == 201) {
        // Parse the response JSON
        final Map<String, dynamic> responseData = json.decode(response.body);
        debugPrint('$responseData');

        // Extract any additional information you may need from the response

        debugPrint('Signed up successfully!');
      } else {
        debugPrint('Error signing up: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error signing up: $e');
      // Handle signup errors here
      rethrow; // Rethrow the exception for the caller to handle
    }
  }
}
