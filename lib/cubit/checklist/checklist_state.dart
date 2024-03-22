import 'package:flutter_application_1/domain/models/checklists.dart';

class ChecklistState {}

class ChecklistLoadingState extends ChecklistState{
  
}

class ChecklistSuccessState extends ChecklistState {
  final Checklists checkLists;
  ChecklistSuccessState(this.checkLists);
}

class ChecklistFailedState extends ChecklistState{
  final String message;
  ChecklistFailedState(this.message);
}

class UpdateChecklistLoadingState extends ChecklistState {}

class UpdateChecklistSuccessState extends ChecklistState {
  final Checklist checkList;
  UpdateChecklistSuccessState(this.checkList);
}

class UpdateChecklistFailedState extends ChecklistState {
  final String message;
  UpdateChecklistFailedState(this.message);
}
