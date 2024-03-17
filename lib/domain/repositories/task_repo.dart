import 'package:dio/dio.dart';

import '../../utils/get_it.dart';
import '../models/tasks.dart';

final Dio _apiClient = getIt.get<Dio>();

class TaskRepo {
  Future<Tasks> getTasks({String? title, String? cageId, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (title != null) queryParameters['code'] = title;
      if (cageId != null) queryParameters['code'] = cageId;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;

      var res = await _apiClient.get('/api/tasks', queryParameters: queryParameters);
      return Tasks.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  } 

  Future<Task> getTaskDetail({required String taskId}) async {
    try {
      var res = await _apiClient.get('/api/tasks/$taskId');
      return Task.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}