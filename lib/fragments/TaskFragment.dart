import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
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
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                create: (context) => TaskCubit()..getTasks(),
                child: BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is TasksLoadingState) {
                      return CircularProgressIndicator().center();
                    }
                    if (state is TasksSuccessState) {
                    var tasks = state.tasks;
                    return Column(
                      children: <Widget>[
                        // Custom TabBar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // Custom tab buttons
                            Expanded(child: CustomTab(title: 'To Do', index: 0, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(0))),
                            Gap.k16.width,
                            Expanded(child: CustomTab(title: 'In progress', index: 1, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(1))),
                            Gap.k16.width,
                            Expanded(child: CustomTab(title: 'Done', index: 2, selectedIndex: _selectedIndex).onTap(() => _onItemTapped(2))),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            TaskComponent(task: tasks.tasks![index],),
                                        separatorBuilder: (context, indext) =>
                                            Gap.k16.height,
                                        itemCount: tasks.tasks!.length),
                                  )
                                ],
                              ).paddingTop(32),
                              Center(child: Text('Search Tab Content')),
                              Center(child: Text('Notifications Tab Content')),
                            ],
                          ),
                        ),
                      ],
                    );
                    }
                    return const SizedBox.shrink();
                  }
                ),
              ),
            ),
          ),
        ],
      ).paddingOnly(left: 16, right: 16, top: 32),
    );
  }
}