import 'package:flutter/material.dart';
import 'package:canteen_app/Users/user_screen.dart';
import 'package:canteen_app/Agent/agent_screen.dart';
import 'package:canteen_app/Manager/manager_screen.dart';
import 'package:canteen_app/Authentication/auth_screen.dart';
import 'package:canteen_app/Inspectors/inspector_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:canteen_app/Services/widgets/common_widgets.dart';
import 'package:canteen_app/Services/api/genaral_api_service.dart';
import 'package:canteen_app/Services/api_models/general_model.dart';
import 'package:canteen_app/Services/api/authentication_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    String email = usernameController.text;
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
          
        case 'DELIVERY':
          // ignore: use_build_context_synchronously
          _navigateToReplacement(context, const AgentScreen());
          break;

        default:
          debugPrint('Unknown user role: $userRole');
          break;
      }
    }).catchError((error) {
      debugPrint('Authentication failed: $error');
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
          controller: usernameController,
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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  SignupForm({Key? key}) : super(key: key);

  bool _validatePassword(String password) {
    // Define password validation criteria here
    // For example, check length and for common or entirely numeric passwords
    return password.length >= 8 &&
        !password.contains('common') &&
        !RegExp(r'^[0-9]+$').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: FutureBuilder<List<Course>>(
        future: GenralService().getCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Course> courses = snapshot.data ?? [];
            List<String> departmentNames =
                courses.map((course) => course.value).toList();

            return Column(
              children: [
                CommonTextField(
                  controller: usernameController,
                  labelText: 'Username',
                ),
                const SizedBox(height: 16.0),
                CommonTextField(
                  controller: nameController,
                  labelText: 'Name',
                ),
                const SizedBox(height: 16.0),
                CommonTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                CommonTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                FormBuilderDropdown(
                  name: 'department',
                  decoration: const InputDecoration(labelText: 'Department'),
                  items: departmentNames
                      .map((department) => DropdownMenuItem(
                            value: department,
                            child: Text(department),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    departmentController.text = value ?? '';
                  },
                ),
                const SizedBox(height: 20),
                CommonButton(
                  onPressed: () async {
                    // Validate password and confirm password match
                    if (passwordController.text != confirmPasswordController.text) {
                      // Show error message if passwords don't match
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords do not match.'),
                        ),
                      );
                      return;
                    }
                    
                    // Validate password strength
                    if (!_validatePassword(passwordController.text)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Password Validation Error'),
                            content: Text(
                                'Password must be at least 8 characters long and not too common or entirely numeric.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    // Sign up with provided credentials
                    await AuthenticationService().signUp(
                      usernameController.text,
                      nameController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                      departmentController.text,
                    );
                    try{
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } catch (error) {
                      debugPrint('Error signing up: $error');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error signing up: $error'),
                        ),
                      );
                    }
                  },
                  text: 'Sign Up',
                ),
              ],
            );
          }
        },
      ),
    );
  }
}