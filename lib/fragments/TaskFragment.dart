import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
import 'package:flutter_application_1/domain/models/tasks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/TaskComponent.dart';
import '../utils/gap.dart';
import '../widgets/Tab.dart';

class TaskFragment extends StatefulWidget {
  @override
  _TaskFragmentState createState() => _TaskFragmentState();
}

class _TaskFragmentState extends State<TaskFragment> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Material(
              color: transparentColor,
              child: BlocProvider<TaskCubit>(
                create: (context) => TaskCubit()..getTasksStaff(),
                child: BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
                  if (state is TasksLoadingState) {
                    return const CircularProgressIndicator().center();
                  }
                  if (state is TasksSuccessState) {
                    var tasks = state.tasks;
                    if (tasks.tasks != null) {
                      var toDoTasks = tasks.tasks!.where((task) => task.status == 'To do').toList();
                      var inProgressTasks = tasks.tasks!.where((task) => task.status == 'In progress').toList();
                      var workFinishedTasks = tasks.tasks!.where((task) => task.status == 'Work finished').toList();
                      var doneTasks = tasks.tasks!.where((task) => task.status == 'Done').toList();
                      return Column(
                        children: <Widget>[
                          // Custom TabBar
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Custom tab buttons
                              Expanded(child: CustomTab(title: 'To Do', index: 0, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(0))),
                              Gap.k8.width,
                              Expanded(child: CustomTab(title: 'In progress', index: 1, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(1))),
                              Gap.k8.width,
                              Expanded(child: CustomTab(title: 'Work finished', index: 2, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(2))),
                              Gap.k8.width,
                              Expanded(child: CustomTab(title: 'Done', index: 3, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(3))),
                            ],
                          ),
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              children: <Widget>[
                                // Nội dung của mỗi "tab"
                                TaskTabView(tasks: toDoTasks).paddingTop(32),
                                TaskTabView(tasks: inProgressTasks).paddingTop(32),
                                TaskTabView(tasks: workFinishedTasks).paddingTop(32),
                                TaskTabView(tasks: doneTasks).paddingTop(32),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: const Text('No task'));
                    }
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ),
          ),
        ],
      ).paddingOnly(left: 16, right: 16, top: 32),
    );
  }
}

class TaskTabView extends StatelessWidget {
  const TaskTabView({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return tasks.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => TaskComponent(
                          task: tasks[index],
                        ),
                    separatorBuilder: (context, indext) => Gap.k16.height,
                    itemCount: tasks.length),
              )
            ],
          )
        : const Center(child: Text('No task'));
  }
}
