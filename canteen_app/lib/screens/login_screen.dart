import 'package:flutter/material.dart';
import 'package:canteen_app/widgets/forms/login_form.dart';
import 'package:canteen_app/widgets/forms/signup_form.dart'; // Import the SignUpForm

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoginForm = true; // Track whether to show login or signup form

  void toggleForm() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showLoginForm ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showLoginForm
            ? Column(
                children: [
                  LoginForm(),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: toggleForm,
                    child: Text('Switch to Sign Up'),
                  ),
                ],
              )
            : Column(
                children: [
                  SignupForm(),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: toggleForm,
                    child: Text('Switch to Login'),
                  ),
                ],
              ),
      ),
    );
  }
}
