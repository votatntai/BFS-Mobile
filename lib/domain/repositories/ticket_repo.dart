import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../models/tickets.dart';

final Dio _apiClient = getIt.get<Dio>();

class TicketRepo {
  Future<Tickets> getTickets({String? cageId, String? ticketCategory, int? pageNumber, int? pageSize}) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (cageId != null) queryParameters['cageId'] = cageId;
      if (ticketCategory != null) queryParameters['ticketCategory'] = ticketCategory;
      if (pageNumber != null) queryParameters['pageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['pageSize'] = pageSize;
      final response = await _apiClient.get('/api/tickets', queryParameters: queryParameters);
      return Tickets.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Tickets> addTicket({String? ticketCategory, String? creatorId, String? priority, String? description, String? assigneeId, String? cageId, XFile? image }) async {
    try {
      FormData formData = FormData.fromMap({
        'ticketCategory': ticketCategory,
        'creatorId': creatorId,
        'priority': priority,
        'description': description,
        'assigneeId': assigneeId,
        'cageId': cageId,
        'ticketImage': await MultipartFile.fromFile(image!.path, filename: 'ticketImage'),
      });
      final response = await _apiClient.post('/api/tickets', data: formData);
      return Tickets.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}