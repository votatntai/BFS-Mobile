import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/models/foods.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../models/foods.dart';
import '../models/food.dart';

final Dio _apiClient = getIt.get<Dio>();

class FoodRepo {
  Future<List<Foodd>> getFoods({String? name, String? status, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (name != null) queryParameters['name'] = name;
      if (status != null) queryParameters['status'] = status;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      var res = await _apiClient.get('/api/foods/GetByMealPlan', queryParameters: queryParameters);
      var rs = (res.data as List).map((e) => Foodd.fromJson(e)).toList();
      return rs;
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Food> updateFood({required String id, XFile? thumbnail, String? foodCategoryId, double? quantity, String? unitOfMeasurement, String? status}) async {
    try {
      FormData formData = FormData.fromMap({
        if (thumbnail != null) 'thumbnail': await MultipartFile.fromFile(thumbnail.path),
        if (foodCategoryId != null) 'foodCategoryId': foodCategoryId,
        if (quantity != null) 'quantity': quantity,
        if (unitOfMeasurement != null) 'unitOfMeasurement': unitOfMeasurement,
        if (status != null) 'status': status,
      });
      var res = await _apiClient.put('/api/foods/$id', data: formData, options: Options(contentType: Headers.multipartFormDataContentType));
      return Food.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<bool> createFoodReport({required String staffId, required String foodId, required double lastQuantity, required double remainQuantity, String? description}) async {
    try {
      await _apiClient.post('/api/food-report', data: {
        'staffId': staffId,
        'foodId': foodId,
        'lastQuantity': lastQuantity,
        'remainQuantity': remainQuantity,
        if (description != null) 'description': description,
      });
      return true;
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}
