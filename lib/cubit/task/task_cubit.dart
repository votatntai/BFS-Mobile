import 'package:flutter_application_1/domain/repositories/task_repo.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo _taskRepo = getIt<TaskRepo>();
  TaskCubit() : super(TaskState());

  Future<void> getTasks({String? title, String? cageId, int? pageNumber, int? pageSize}) async {
    emit(TasksLoadingState());
    try {
      var tasks = await _taskRepo.getTasks(title: title, cageId: cageId, pageNumber: pageNumber, pageSize: pageSize);
      emit(TasksSuccessState(tasks: tasks));
    } catch (e) {
      emit(TasksFailedState(e.toString()));
    }
  }

  Future<void> getTaskDetail(String taskId) async {
    emit(TaskDetailLoadingState());
    try {
      var task = await _taskRepo.getTaskDetail(taskId: taskId);
      emit(TaskDetailSuccessState(task: task));
    } catch (e) {
      emit(TaskDetailFailedState(e.toString()));
    }
  }
}
