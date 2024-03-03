import 'package:flutter/material.dart';
import 'package:canteen_app/Authentication/auth_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoginForm = true;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showLoginForm ? const LoginForm() : SignupForm(),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: toggleForm,
              child: Text(
                showLoginForm
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Sign In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
