import 'package:dio/dio.dart';

import '../../utils/get_it.dart';
import '../models/tasks.dart';

final Dio _apiClient = getIt.get<Dio>();

class TaskRepo {
  Future<Tasks> getTasksStaff({int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;

      var res = await _apiClient.get('/api/tasks/staffs', queryParameters: queryParameters);
      return Tasks.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<Tasks> getTasks({String? title, String? cageId, String? managerId, bool? status, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (title != null) queryParameters['title'] = title;
      if (cageId != null) queryParameters['cageId'] = cageId;
      if (managerId != null) queryParameters['managerId'] = managerId;
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

  Future<Task> updateTask({required String taskId, String? cageId, String? title, String? description, String? deadline, String? status}) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'cageId': cageId,
        'description': description,
        'deadline': deadline,
        'status': status,
      });
      var res = await _apiClient.put('/api/tasks/$taskId', data: formData, options: Options(contentType: Headers.multipartFormDataContentType));
      return Task.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}