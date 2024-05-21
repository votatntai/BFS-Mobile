import 'package:dio/dio.dart';
import 'package:flutter_application_1/cubit/staff/staff_cubit.dart';
import 'package:flutter_application_1/domain/repositories/bird_category_repo.dart';
import 'package:flutter_application_1/domain/repositories/bird_repo.dart';
import 'package:flutter_application_1/domain/repositories/cage_repo.dart';
import 'package:flutter_application_1/domain/repositories/checklist_repo.dart';
import 'package:flutter_application_1/domain/repositories/food_repo.dart';
import 'package:flutter_application_1/domain/repositories/meal_plan_repo.dart';
import 'package:flutter_application_1/domain/repositories/notification_repo.dart';
import 'package:flutter_application_1/domain/repositories/species_repo.dart';
import 'package:flutter_application_1/domain/repositories/ticket_repo.dart';
import 'package:flutter_application_1/domain/repositories/user_repo.dart';
import 'package:flutter_application_1/utils/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/repositories/task_repo.dart';

final getIt = GetIt.instance;

Future<void> initialGetIt() async {
  getIt.registerLazySingleton<Dio>(() => apiClient);

  getIt.registerLazySingleton(() => UserRepo());
  getIt.registerLazySingleton(() => BirdRepo());
  getIt.registerLazySingleton(() => CageRepo());
  getIt.registerLazySingleton(() => TaskRepo());
  getIt.registerLazySingleton(() => ChecklistRepo());
  getIt.registerLazySingleton(() => TicketRepo());
  getIt.registerLazySingleton(() => FoodRepo());
  getIt.registerLazySingleton(() => MealPlanRepo());
  getIt.registerLazySingleton(() => BirdCategoryRepo());
  getIt.registerLazySingleton(() => SpeciesRepo());
  getIt.registerLazySingleton(() => NotificationRepo());
  getIt.registerLazySingleton(() => StaffCubit());
}