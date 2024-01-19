import 'package:flutter/material.dart';
import 'package:canteen_app/services/authentication_service.dart';
import 'package:canteen_app/screens/user_screen.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {
            // Add authentication logic here
            String email = emailController.text;
            String password = passwordController.text;
            AuthenticationService().signIn(email, password);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
              );
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
