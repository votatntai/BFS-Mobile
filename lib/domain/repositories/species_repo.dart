import 'package:dio/dio.dart';
import '../../utils/get_it.dart';
import '../../utils/messages.dart';
import '../models/birdspecies.dart';

final Dio _apiClient = getIt<Dio>();

class SpeciesRepo {
  Future<BirdSpecies> getSpecies({String? name, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {
        if(name != null) 'name': name,
        if(pageNumber != null) 'pageNumber': pageNumber,
        if(pageSize != null) 'pageSize': pageSize
      };
      var response = await _apiClient.get('/api/species', queryParameters: queryParameters);
      return BirdSpecies.fromJson(response.data);
    } on DioException catch (e) {
      print("Error at getSpecies: $e");
      throw Exception(msg_server_error);
    }
  }
}