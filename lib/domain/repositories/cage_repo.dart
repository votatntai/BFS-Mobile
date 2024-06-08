import 'package:dio/dio.dart';


import '../../utils/get_it.dart';
import '../models/cages.dart';

final Dio _apiClient = getIt.get<Dio>();

class CageRepo {
  Future<Cages> getCages({String? code, String? farmId, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (code != null) queryParameters['code'] = code;
      if (farmId != null) queryParameters['farmId'] = farmId;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;

      var res = await _apiClient.get('/api/cages', queryParameters: queryParameters);
      return Cages.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<Cage> getCageDetail(String id) async {
    try {
      var res = await _apiClient.get('/api/cages/$id');
      return Cage.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}