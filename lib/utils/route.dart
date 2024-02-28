import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LoginScreen.dart';

import '../screens/DashboardScreen.dart';
import '../screens/NotFoundScreen.dart';
import '../fragments/ProfileFragment.dart';
import '../screens/SettingScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case DashboardScreen.routeName:
      return MaterialPageRoute(builder: (_) => DashboardScreen());
    case '/settings':
      return MaterialPageRoute(builder: (_) => SettingsScreen());
    default:
      return MaterialPageRoute(builder: (_) => NotFoundScreen());
  }
}


