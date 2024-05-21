import 'package:dio/dio.dart';
import '../../utils/get_it.dart';
import '../../utils/messages.dart';
import '../models/notifications.dart';

final Dio _apiClient = getIt.get<Dio>();

class NotificationRepo {
  Future<Notifications> getNotifications({int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;
      var res = await _apiClient.get('/api/notifications/staffs', queryParameters: queryParameters);
      return Notifications.fromJson(res.data);
    } on DioException catch (e) {
      print("Error at getNotifications: $e");
      throw Exception(msg_server_error);
    }
  }

  Future<int> markAsRead({required String notificationId}) async {
    try {
      var res = await _apiClient.put('/api/notifications/$notificationId', data: {'isRead': true});
      return res.statusCode!;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<int> markAllAsRead() async {
    try {
      var res = await _apiClient.get('/api/notifications/mark-as-read/staffs');
      return res.statusCode!;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
