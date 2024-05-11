import 'package:dio/dio.dart';

import '../../utils/get_it.dart';
import '../models/birdcategories.dart';

final Dio _apiClient = getIt.get<Dio>();

class BirdCategoryRepo {

  Future<BirdCategories> getBirdCategories({String? name, int? pageNumber, int? pageSize}) async {
    try {
      var res = await _apiClient.get('/api/bird-categories');
      return BirdCategories.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}