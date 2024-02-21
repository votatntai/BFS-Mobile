import 'package:dio/dio.dart';

import 'package:nb_utils/nb_utils.dart';

import 'constants.dart';

final apiClient = Dio()
  ..options.baseUrl = AppConstant.API_URL
  ..options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  }
  ..interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = getStringAsync(AppConstant.TOKEN_KEY);
        if (token.isNotEmpty) {
          request.headers['Authorization'] = token;
        }
        return handler.next(request); // continue
      },
    )
  ]);
