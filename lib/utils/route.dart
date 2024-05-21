import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/MealPlanDetailScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notification/notification_cubit.dart';
import '../screens/AddTicketScreen.dart';
import '../screens/BirdDetailScreen.dart';
import '../screens/CageDetailScreen.dart';
import '../screens/DashboardScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/NotFoundScreen.dart';
import '../screens/NotificationScreen.dart';
import '../screens/SettingScreen.dart';
import '../screens/TaskDetailScreen.dart';
import '../screens/TasksScreen.dart';
import '../screens/TicketDetailScreen.dart';
import '../screens/TicketsScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case DashboardScreen.routeName:
      return MaterialPageRoute(builder: (_) => DashboardScreen(tabIndex: settings.arguments as int,));
    case '/settings':
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    case '/bird-detail':
      return MaterialPageRoute(builder: (_) => BirdDetailScreen(birdId: settings.arguments.toString(),));
    case '/task-detail':
      return MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: settings.arguments.toString(),));
    case '/cage-detail':
      return MaterialPageRoute(builder: (_) => CageDetailScreen(cageId: settings.arguments.toString(),));
    case TicketsScreen.routeName:
      return MaterialPageRoute(builder: (_) => TicketsScreen(cageId: settings.arguments.toString(),));
    case AddTicketScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddTicketScreen());
    case TasksScreen.routeName:
      return MaterialPageRoute(builder: (_) => TasksScreen(cageId: settings.arguments.toString(),));
    case TicketDetailScreen.routeName:
      return MaterialPageRoute(builder: (_) => TicketDetailScreen(ticketId: settings.arguments.toString(),));
    case MealPlanDetailScreen.routeName:
      return MaterialPageRoute(builder: (_) => MealPlanDetailScreen(mealPlanId: settings.arguments.toString(),));
    case NotificationScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
                BlocProvider<NotificationCubit>(create: (context) => NotificationCubit()..getNotifications(pageSize: 1000)),
                BlocProvider<MarkAsReadNotificationCubit>(create: (context) => MarkAsReadNotificationCubit())
              ], child: const NotificationScreen()));
    default:
      return MaterialPageRoute(builder: (_) => const NotFoundScreen());
  }
}


