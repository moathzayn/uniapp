import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniapp/screens/login_screen.dart';
import 'package:uniapp/screens/signup_screen.dart';
import 'package:uniapp/uitls/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: primaryColor,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpScreen(),
    );
  }
}
