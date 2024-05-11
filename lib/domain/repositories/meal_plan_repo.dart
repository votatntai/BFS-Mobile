import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/get_it.dart';

import '../models/mealplans.dart';

final Dio _apiClient = getIt.get<Dio>();

class MealPlanRepo {
  Future<MealPlans> getMealPlans({DateTime? from, DateTime? to, String? menuId, String? cageId, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (from != null) queryParameters['from'] = from.toIso8601String();
      if (to != null) queryParameters['to'] = to.toIso8601String();
      if (menuId != null) queryParameters['menuId'] = menuId;
      if (cageId != null) queryParameters['cageId'] = cageId;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;

      var res = await _apiClient.get('/api/plans', queryParameters: queryParameters);
      return MealPlans.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<MealPlan> getMealPlan({required String id}) async {
    try {
      var res = await _apiClient.get('/api/plans/$id');
      return MealPlan.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}
