import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/models/checklists.dart';
import 'package:flutter_application_1/utils/get_it.dart';

final Dio _apiClient = getIt.get<Dio>();

class ChecklistRepo {
  Future<Checklist> updateChecklistStatus({required String id, bool? status, String? assigneeId}) async {
    try {
      var res = await _apiClient.put('/api/task-check-lists/$id', data: FormData.fromMap({'assigneeId' : assigneeId, 'status': status}), options: Options(contentType: Headers.multipartFormDataContentType));
      return Checklist.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<Checklists> getChecklist({String? title, String? assigneeId, int? pageSize, int? pageNumber}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (title != null) queryParameters['title'] = title;
      if (assigneeId != null) queryParameters['assigneeId'] = assigneeId;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      var res = await _apiClient.get('/api/task-check-lists', queryParameters: queryParameters);
      return Checklists.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response!.data);
    }
  }
}