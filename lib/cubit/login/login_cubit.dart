import 'package:flutter_application_1/domain/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/get_it.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepo _userRepo = getIt<UserRepo>();

  LoginCubit() : super(LoginState());
  
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await _userRepo.login(email: email, password: password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailedState(e.toString()));
    }
  }
}
