import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final String baseUrl = 'http://127.0.0.1:8000';

  // Key for storing the auth token in SharedPreferences
  static const String authTokenKey = 'authToken';

  // Save the auth token to SharedPreferences
  static Future<void> saveAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authTokenKey, authToken);
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

        // Save the auth token
        await saveAuthToken(authToken);

        print('Signed in successfully!');
      } else {
        print('Error signing in: ${response.statusCode}');
        // Handle sign-in errors here
      }
    } catch (e) {
      print('Error signing in: $e');
      // Handle sign-in errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }

  Future<void> signOut() async {
    try {
      // Clear the auth token from SharedPreferences
      await saveAuthToken('');

      final response = await http.post(
        Uri.parse('$baseUrl/api/mobile/logout/'),
        // Additional headers or data if needed
      );

      if (response.statusCode == 200) {
        print('Signed out successfully!');
      } else {
        print('Error signing out: ${response.statusCode}');
        // Handle sign-out errors here
      }
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }
}
