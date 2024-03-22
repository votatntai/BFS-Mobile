
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/task_repo.dart';
import '../../utils/get_it.dart';
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

  Future<void> updateTask({required String taskId, String? cageId, String? title, String? description, String? deadline, String? status}) async {
    // emit(TaskUpdateLoadingState());
    try {
      var task = await _taskRepo.updateTask(taskId: taskId, cageId: cageId, title: title, description: description, deadline: deadline, status: status);
      emit(TaskDetailSuccessState(task: task));
    } catch (e) {
      emit(TaskUpdateFailedState(e.toString()));
    }
  }
}
