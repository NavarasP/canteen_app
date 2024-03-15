import 'package:flutter/material.dart';
import 'package:canteen_app/Authentication/auth_screen.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, String?>>(
            future: AuthenticationService.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading user details: ${snapshot.error}');
              } else {
                final user = snapshot.data;

                // Extract user details
                final String? username = user?['username'];
                final String? name = user?['name'];
                final String? userType = user?['userType'];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle, // Use the account_circle icon
                      size: 100,
                      color: Colors.blue,
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
                        await AuthenticationService().signOut();

                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
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
