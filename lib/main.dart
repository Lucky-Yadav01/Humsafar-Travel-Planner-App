import 'package:flutter/material.dart';
import 'pages/signup_page.dart';
import 'pages/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HUMSAFAR',
      theme: AppTheme.light(),
      home: const SignUpPage(), // loading the signuppage first
    );
  }
}
