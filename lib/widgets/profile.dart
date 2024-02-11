import 'package:flutter/material.dart';
import 'package:canteen_app/Authentication/auth_screen.dart';
import 'package:canteen_app/services/api/authentication_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, String?>>(
            // Use FutureBuilder to asynchronously retrieve the user details
            future: AuthenticationService.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // If still loading, display a loading indicator
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurred, display an error message
                return Text('Error loading user details: ${snapshot.error}');
              } else {
                // If successful, retrieve the user details
                final user = snapshot.data;

                // Extract user details
                final String? username = user?['username'];
                final String? name = user?['name'];
                final String? userType = user?['userType'];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      // Add your user's profile picture here
                      // backgroundImage: NetworkImage('URL_TO_USER_PROFILE_PICTURE'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Hello, ${username ?? 'User'}!', // Display the username
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Display other user details
                    Text(
                      'Name: ${name ?? 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'User Type: ${userType ?? 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        // Call the logout function
                        await AuthenticationService().signOut();

                        // Navigate to the login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
