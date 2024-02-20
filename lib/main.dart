import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/route.dart';

import 'screens/DashboardScreen.dart';
import 'screens/LoginScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      onGenerateRoute: generateRoute,

      home: _fetchAuthAndInitialRoute(),
    );
  }
}

Widget _fetchAuthAndInitialRoute() {
  // Check if logged in
  bool isLoggedIn = false; // Replace with your authentication logic
  try {
    if (isLoggedIn) {
      return DashboardScreen();
    } else {
      return const LoginScreen();
    }
  } catch (e) {
    return const LoginScreen();
  }
}

