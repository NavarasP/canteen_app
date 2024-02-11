import 'package:flutter/material.dart';
import 'package:canteen_app/services/color_schemes.g.dart';
import 'package:canteen_app/Authentication/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen Management App',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}