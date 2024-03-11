import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_repo.dart';
import '../../utils/get_it.dart';
import 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  final UserRepo _userRepo = getIt<UserRepo>();

  StaffCubit() : super(StaffState());
  
  Future<void> getStaffInformation() async {
    emit(StaffLoadingState());
    try {
      var staff = await _userRepo.getStaffInformation();
      emit(StaffSuccessState(staff));
    } catch (e) {
      emit(StaffFailedState(e.toString()));
    }
  }
}
