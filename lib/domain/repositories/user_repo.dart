import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/Constants.dart';
import '../../utils/get_it.dart';
import '../../utils/messages.dart';

class UserRepo {
  final Dio apiClient = getIt.get<Dio>();
  Future<void> login({required String email, required String password}) async {
    try {
      var res = await apiClient.post('/api/auth/staffs', data: {'email': email, 'password': password});
      var accessToken = res.data['accessToken'];
      if (accessToken.isEmpty || accessToken == null) {
        throw Exception(msg_login_token_invalid);
      }
      await setValue(AppConstant.TOKEN_KEY, accessToken);
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        throw Exception(e.response!.data);
      }
      throw Exception(msg_server_error);
    }
  }
}