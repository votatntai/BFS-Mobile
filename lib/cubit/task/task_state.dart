import '../../domain/models/tasks.dart';

class TaskState {}

class TasksLoadingState extends TaskState {}

class TasksSuccessState extends TaskState {
  final Tasks tasks;
  TasksSuccessState({required this.tasks});
}

class TasksFailedState extends TaskState {
  final String msg;
  TasksFailedState(this.msg);
}

class TaskDetailLoadingState extends TaskState {}

class TaskDetailSuccessState extends TaskState {
  final Task task;
  TaskDetailSuccessState({required this.task});
}

class TaskDetailFailedState extends TaskState {
  final String msg;
  TaskDetailFailedState(this.msg);
}

class TaskUpdateLoadingState extends TaskState {}

class TaskUpdateSuccessState extends TaskState {
  final int statusCode;
  TaskUpdateSuccessState({required this.statusCode});
}

class TaskUpdateFailedState extends TaskState {
  final String msg;
  TaskUpdateFailedState(this.msg);
}
