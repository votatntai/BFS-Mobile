import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/checklist/checklist_cubit.dart';
import 'package:flutter_application_1/cubit/checklist/checklist_state.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
import 'package:flutter_application_1/screens/DashboardScreen.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/checklists.dart';
import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

enum TaskStatus { toDo, inProgress, workFinished, done }

class TaskDetailScreen extends StatefulWidget {
  static const routeName = '/task-detail';
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String status = '';
  List<Map<String, bool>> checklists = [
    {'Cho chim A ăn 1 lượng cám 3g': false},
    {'Kiểm tra tình trạng chim B': false},
    {'Đo nhiệt độ chim C': false},
    {'Đo nhiệt độ chim Czzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz': false}
  ];

  TaskStatus _convertStatusToEnum(String status) {
    switch (status) {
      case 'To do':
        return TaskStatus.toDo;
      case 'In progress':
        return TaskStatus.inProgress;
      case 'Work finished':
        return TaskStatus.workFinished;
      case 'Done':
        return TaskStatus.done;
      default:
        return TaskStatus.toDo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Task Detail',
        leadingIcon: AppAssets.angle_left_svg,
        previousScreen: DashboardScreen.routeName,
      ),
      body: Background(
          widget: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TaskCubit()..getTaskDetail(widget.taskId)), BlocProvider(create: (context) => ChecklistCubit()..getChecklist())],
        // create: (context) => TaskCubit()..getTaskDetail(widget.taskId),
        child: BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
          if (state is TaskDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskDetailSuccessState) {
            var task = state.task;
            TaskStatus currentStatus = _convertStatusToEnum(task.status!);

            bool shouldDisplayTitle(TaskStatus containerStatus) {
              return currentStatus.index <= containerStatus.index;
            }

            final uniqueAssignees = <Assignee>{};
            // Duyệt qua danh sách checkLists và thêm assignee vào Set
            for (var checklist in task.checkLists!) {
              if (checklist.assignee != null) {
                uniqueAssignees.add(checklist.assignee!);
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title!, style: boldTextStyle(size: 20)),
                16.height,
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            Gap.k4.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.users_svg, width: 16, height: 16, color: Colors.grey),
                                Gap.k8.width,
                                Text('Assignees', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                            Gap.k16.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.circle_half_stroke_svg, height: 16, color: Colors.grey),
                                Gap.k8.width,
                                Text('Status', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                            Gap.k16.height,
                            // Gap.k2.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.clock_svg, height: 16, color: Colors.grey),
                                Gap.k8.width,
                                Text('Deadline', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                            Gap.k16.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.dove_svg, height: 16, color: Colors.grey),
                                Gap.k8.width,
                                Text('Species', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                            14.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.cage_svg, height: 24, color: Colors.grey),
                                Gap.k8.width,
                                Text('Cage', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                            12.height,
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.hand_holding_medical_svg, height: 16, color: Colors.grey),
                                Gap.k8.width,
                                Text('Care mode', style: secondaryTextStyle(size: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap.k16.width,
                      Flexible(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 26,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(24)),
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 25,
                                              width: 25,
                                              decoration: const BoxDecoration(shape: BoxShape.circle),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: AppAssets.placeholder,
                                                    image: uniqueAssignees.toList()[index].avatarUrl!,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          Gap.k8.width,
                                          Text(uniqueAssignees.toList()[index].name!, style: primaryTextStyle(weight: FontWeight.w500, size: 14)),
                                          Gap.k4.width
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => Gap.k8.width,
                                  itemCount: uniqueAssignees.toList().length),
                            ),
                            Gap.k8.height,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(color: task.status == 'To do' ? dodgerBlue.withOpacity(0.3) : grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.circle_svg, width: 14, height: 14, color: task.status == 'To do' ? dodgerBlue : grey),
                                        if (shouldDisplayTitle(TaskStatus.toDo))
                                          Row(
                                            children: [
                                              Gap.k4.width,
                                              Text('To do', style: TextStyle(fontSize: 14, color: task.status == 'To do' ? dodgerBlue : grey, fontWeight: FontWeight.bold)),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  Gap.k8.width,
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(color: task.status == 'In progress' ? goldenRod.withOpacity(0.3) : grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.circle_half_stroke_svg, width: 14, height: 14, color: task.status == 'In progress' ? goldenRod : grey),
                                        if (shouldDisplayTitle(TaskStatus.inProgress))
                                          Row(
                                            children: [
                                              Gap.k4.width,
                                              Text('In progress', style: TextStyle(fontSize: 14, color: task.status == 'In progress' ? goldenRod : grey, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Gap.k8.width,
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(color: task.status == 'Work finished' ? slateBlue.withOpacity(0.3) : grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.solid_circle, width: 14, height: 14, color: task.status == 'Work finished' ? slateBlue : grey),
                                        if (shouldDisplayTitle(TaskStatus.workFinished))
                                          Row(
                                            children: [
                                              Gap.k4.width,
                                              Text('Work finished', style: TextStyle(fontSize: 14, color: task.status == 'Work finished' ? slateBlue : grey, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Gap.k8.width,
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(color: task.status == 'Done' ? forestGreen.withOpacity(0.3) : grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.circle_check_svg, width: 14, height: 14, color: task.status == 'Done' ? forestGreen : grey),
                                        if (shouldDisplayTitle(TaskStatus.done))
                                          Row(
                                            children: [
                                              Gap.k4.width,
                                              Text('Done', style: TextStyle(fontSize: 14, color: task.status == 'Done' ? forestGreen : grey, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap.k16.height,
                            Gap.k2.height,
                            Text(DateFormat("HH:mm dd-MM-yyyy").format(DateTime.parse(task.deadLine!)), style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                            Gap.k16.height,
                            Text(task.cage!.species!.name!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                            Gap.k16.height,
                            // Gap.k2.height,
                            Text(task.cage!.name!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                            Gap.k16.height,
                            Text(task.cage!.careMode!.name!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gap.kSection.height,
                Text('Checklists', style: secondaryTextStyle(size: 14)),
                BlocBuilder<ChecklistCubit, ChecklistState>(builder: (context, state) {
                  // if (state is ChecklistLoadingState) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  if (state is ChecklistSuccessState) {
                    var checklists = state.checkLists.checklists;
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var updateChecklistCubit = context.read<ChecklistCubit>();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 7,
                                child: Text(task.checkLists![index].title!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                              ),
                              Flexible(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Checkbox(
                                        activeColor: primaryColor,
                                        value: checklists![index].status,
                                        onChanged: (value) {
                                          updateChecklistCubit.updateChecklistStatus(checklists[index].id!, value!);
                                          if (updateChecklistCubit is UpdateChecklistFailedState) {
                                            Fluttertoast.showToast(msg: (updateChecklistCubit.state as UpdateChecklistFailedState).message);
                                          }
                                          // setState(() {
                                          //   checklists[index] = {checklists[index].keys.first: !checklists[index].values.first};
                                          // });
                                        }),
                                    IconButton(onPressed: () {}, icon: SvgPicture.asset(AppAssets.pen_to_square_svg, width: 16, height: 16, color: Colors.grey))
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => Gap.k8.height,
                        itemCount: task.checkLists!.length);
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16);
          }
          return const SizedBox.shrink();
        }),
      )),
    );
  }
}
