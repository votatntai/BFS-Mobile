import 'package:dio/dio.dart';
import '../../utils/get_it.dart';
import '../models/birds.dart';

final Dio _apiClient = getIt.get<Dio>();

class BirdRepo {
  Future<Birds> getBirds({String? name, String? categoryId, String? speciesId, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (name != null) queryParameters['name'] = name;
      if (categoryId != null) queryParameters['categoryId'] = categoryId;
      if (speciesId != null) queryParameters['speciesId'] = speciesId;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;

      var res = await _apiClient.get('/api/birds', queryParameters: queryParameters);
      return Birds.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<Bird> getBirdDetail(String id) async {
    try {
      var res = await _apiClient.get('/api/birds/$id');
      return Bird.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}
