import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LoginScreen.dart';

import '../screens/BirdDetailScreen.dart';
import '../screens/CageDetailScreen.dart';
import '../screens/DashboardScreen.dart';
import '../screens/NotFoundScreen.dart';
import '../screens/SettingScreen.dart';
import '../screens/TaskDetailScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case DashboardScreen.routeName:
      return MaterialPageRoute(builder: (_) => DashboardScreen());
    case '/settings':
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    case '/bird-detail':
      return MaterialPageRoute(builder: (_) => BirdDetailScreen(birdId: settings.arguments.toString(),));
    case '/task-detail':
      return MaterialPageRoute(builder: (_) => const TaskDetailScreen());
    case '/cage-detail':
      return MaterialPageRoute(builder: (_) => CageDetailScreen(cageId: settings.arguments.toString(),));
    default:
      return MaterialPageRoute(builder: (_) => const NotFoundScreen());
  }
}


