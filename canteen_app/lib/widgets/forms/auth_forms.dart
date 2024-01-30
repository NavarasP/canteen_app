import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:canteen_app/services/authentication_service.dart';
import 'package:canteen_app/screens/user_screen.dart';
import 'package:canteen_app/widgets/common_widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      // Show loading indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: CircularProgressIndicator(),
          );
        },
        barrierDismissible: false,
      );

      // Call the authentication service to sign in
      await AuthenticationService().signIn(email, password);

      // Navigate to the user screen on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserScreen()),
      );
    } catch (error) {
      // Handle authentication errors
      // You may want to display an error message to the user
      print('Authentication failed: $error');

      // Close the loading indicator
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          controller: emailController,
          labelText: 'Email',
        ),
        const SizedBox(height: 16.0),
        CommonTextField(
          controller: passwordController,
          labelText: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 24.0),
        CommonButton(
          onPressed: () => _login(context),
          text: 'Login',
        ),
      ],
    );
  }
}





class SignupForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController admissionNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          CommonTextField(
            controller: emailController,
            labelText: 'Email',
          ),
          const SizedBox(height: 16.0),
          CommonTextField(
            controller: passwordController,
            labelText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          FormBuilderDropdown(
            name: 'department',
            decoration: const InputDecoration(labelText: 'Department'),
            items: ['Department A', 'Department B', 'Department C']
                .map((department) => DropdownMenuItem(
                      value: department,
                      child: Text(department),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16.0),
          CommonTextField(
            controller: admissionNumberController,
            labelText: 'Admission Number',
          ),
          const SizedBox(height: 20),
          CommonButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                var formData = _formKey.currentState?.value;
                print(formData);
              }
            },
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }
}
