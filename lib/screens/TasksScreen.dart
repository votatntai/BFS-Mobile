import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/TaskComponent.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_application_1/widgets/AppBar.dart';
import 'package:flutter_application_1/widgets/Background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.cageId});
  static const String routeName = '/tasks';
  final String cageId;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Tasks',
        ),
        body: Background(
            child: BlocProvider<TaskCubit>(
          create: (context) => TaskCubit()..getTasks(cageId: widget.cageId),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TasksLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TasksSuccessState) {
                var tasks = state.tasks.tasks!.where((t) => t.title!.toLowerCase().contains(searchController.text.toLowerCase()) || t.status!.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Search by title',
                            prefixIcon: Transform.scale(scale: 0.4,child: SvgPicture.asset(AppAssets.magnifying_glass_svg, color: grey, width: 20, height: 20,),),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Gap.k16.height,
                      tasks.isNotEmpty ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        separatorBuilder: (context, index) => Gap.k8.height,
                        itemBuilder: (context, index) => TaskComponent(task: tasks[index]),
                      ) : Center(
                        child: Text('No tasks found', style: boldTextStyle(color: grey)),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        )));
  }
}
