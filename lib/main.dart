import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_application_1/utils/route.dart';
import 'package:nb_utils/nb_utils.dart';

import 'screens/DashboardScreen.dart';
import 'screens/LoginScreen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await initialGetIt();
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
  try {
    var accessToken = getStringAsync(AppConstant.TOKEN_KEY);
    if (accessToken.isNotEmpty) {
      return DashboardScreen();
    }
  } catch (e) {
    debugPrint("ex ${e.toString()}"); // Print exception 
  }
    return const LoginScreen();
}

