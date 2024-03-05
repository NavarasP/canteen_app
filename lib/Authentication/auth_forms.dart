import 'package:flutter/material.dart';
import 'package:canteen_app/Users/user_screen.dart';
import 'package:canteen_app/Manager/manager_screen.dart';
import 'package:canteen_app/Inspectors/inspector_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:canteen_app/Services/widgets/common_widgets.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    AuthenticationService().signIn(email, password).then((_) async {
      final Map<String, String?> userDetails =
          await AuthenticationService.getUserDetails();
      final String? userRole = userDetails['userType'];
      debugPrint(userRole);

      switch (userRole) {
        case 'STUDENT':
          // ignore: use_build_context_synchronously
          _navigateToReplacement(context, const UserScreen());
          break;
        case 'TEACHER':
          // ignore: use_build_context_synchronously
          _navigateToReplacement(context, const InspectorScreen());
          break;
        case 'MANAGER':
          // ignore: use_build_context_synchronously
          _navigateToReplacement(context, const CanteenTeamScreen());
          break;
        default:
          debugPrint('Unknown user role: $userRole');
          break;
      }
    }).catchError((error) {
      debugPrint('Authentication failed: $error');
      // Handle errors (display error message to the user)
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _navigateToReplacement(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          controller: emailController,
          labelText: 'Username or Phone Number',
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
  final TextEditingController admissionNumberController =
      TextEditingController();

  SignupForm({super.key});

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
                debugPrint('$formData');
              }
            },
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }
}
