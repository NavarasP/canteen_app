import 'package:flutter/material.dart';
import 'package:canteen_app/services/authentication_service.dart';

class ProfilePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              // Add your user's profile picture here
              // backgroundImage: NetworkImage('URL_TO_USER_PROFILE_PICTURE'),
            ),
            SizedBox(height: 20),
            Text(
              'Hello, userName!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'userDetails',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Call the logout function
                await AuthenticationService().signOut();

                // Navigate to the login screen
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
