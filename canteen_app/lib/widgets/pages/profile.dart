import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userDetails;
  final Function() onLogout;

  ProfilePage({
    required this.userName,
    required this.userDetails,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // Add your user's profile picture here
              backgroundColor: Colors.blue, // Placeholder color
              // backgroundImage: NetworkImage('URL_TO_USER_PROFILE_PICTURE'),
            ),
            SizedBox(height: 20),
            Text(
              'Hello, $userName!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              userDetails,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: onLogout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
