import '../../domain/models/staff.dart';

class StaffState {}

class StaffLoadingState extends StaffState {}

class StaffSuccessState extends StaffState {
  final Staff staff;
  StaffSuccessState(this.staff);
}

class StaffFailedState extends StaffState {
  final String error;
  StaffFailedState(this.error);
}
