import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000';
  // final String baseUrl = 'https://fn5bbnp1-8000.inc1.devtunnels.ms';

  // Key for storing the auth token in SharedPreferences
  static const String authTokenKey = 'authToken';

  // Save the auth token to SharedPreferences
  Future<void> saveUserDetails(
      String authToken, String username, String name, String userType) async {
    // Use SharedPreferences to save user details locally
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', authToken);
    prefs.setString('username', username);
    prefs.setString('name', name);
    prefs.setString('userType', userType);
  }

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'username': prefs.getString('username'),
      'name': prefs.getString('name'),
      'userType': prefs.getString('userType'),
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

      if (response.statusCode == 201) {
        // Parse the response JSON
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the auth token from the response
        final String authToken = responseData['data']['auth_token'];
        final String username = responseData['data']['username'];
        final String name = responseData['data']['name'];
        final String userType = responseData['data']['type'];

        // Save the auth token
        await saveUserDetails(authToken, username, name, userType);

        debugPrint('Signed in successfully!');
      } else {
        debugPrint('Error signing in: ${response.statusCode}');
        // Handle sign-in errors here
      }
    } catch (e) {
      debugPrint('Error signing in: $e');
      // Handle sign-in errors here
      throw e; // Rethrow the exception for the caller to handle
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
      throw e; // Rethrow the exception for the caller to handle
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
        // Handle signup errors here
        // You might want to throw an exception or return an error message
      }
    } catch (e) {
      debugPrint('Error signing up: $e');
      // Handle signup errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }
}
