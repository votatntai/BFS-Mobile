
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

  Future<bool> addTicket({required String title, String? ticketCategory, String? creatorId, String? priority, required String description, String? assigneeId, String? cageId, required XFile image }) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'ticketCategory': ticketCategory,
        'creatorId': creatorId,
        'priority': priority,
        'description': description,
        'assigneeId': assigneeId,
        'cageId': cageId,
        'status': 'Processing',
        'image': await MultipartFile.fromFile(image.path, filename: 'ticketImage-$title'),
      });
      await _apiClient.post('/api/tickets', data: formData, options: Options(contentType: Headers.multipartFormDataContentType));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Ticket> getTicketById(String ticketId) async {
    try {
      final response = await _apiClient.get('/api/tickets/$ticketId');
      return Ticket.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateTicket({required String ticketId, String? status, String? ticketCategory, String? creatorId, String? title, String? assigneeId, String? cageId, String? description, XFile? image, String? resultDescription, XFile? resultImage}) async {
    try {
      FormData formData = FormData.fromMap({
        if(ticketCategory != null)
        'ticketCategory': ticketCategory,
        if(creatorId != null)
        'creatorId': creatorId,
        if(title != null)
        'title': title,
        if(assigneeId != null)
        'assigneeId': assigneeId,
        if(cageId != null)
        'cageId': cageId,
        if(description != null)
        'description': description,
        if(image != null)
        'image': await MultipartFile.fromFile(image.path, filename: 'ticketImage-$title'),
        if(status != null)
        'status': status,
        if(resultDescription != null)
        'resultDescription': resultDescription,
        if(resultImage != null)
        'resultImage': await MultipartFile.fromFile(resultImage.path, filename: 'ticketResultImage-$title'),
      });
      await _apiClient.put('/api/tickets/$ticketId', data: formData, options: Options(contentType: Headers.multipartFormDataContentType));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}