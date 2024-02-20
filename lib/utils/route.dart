import 'package:flutter/material.dart';

import '../screens/DashboardScreen.dart';
import '../screens/NotFoundScreen.dart';
import '../screens/ProfileScreen.dart';
import '../screens/SettingScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Add your route cases here
    case DashboardScreen.routeName:
      return MaterialPageRoute(builder: (_) => DashboardScreen());
    case '/profile':
      return MaterialPageRoute(builder: (_) => ProfileScreen());
    case '/settings':
      return MaterialPageRoute(builder: (_) => SettingsScreen());
    default:
      return MaterialPageRoute(builder: (_) => NotFoundScreen());
  }
}


