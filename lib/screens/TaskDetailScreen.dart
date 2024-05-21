import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cubit/checklist/checklist_cubit.dart';
import 'package:flutter_application_1/cubit/checklist/checklist_state.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/checklists.dart';
import '../domain/repositories/user_repo.dart';
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

  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Task Detail',
        leadingIcon: AppAssets.angle_left_svg,
        isRefresh: true,
      ),
      body: Background(
          child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TaskCubit()..getTaskDetail(widget.taskId)), BlocProvider(create: (context) => ChecklistCubit()..getChecklist(pageSize: 100))],
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
                                                  child: uniqueAssignees.toList()[index].avatarUrl != null ? FadeInImage.assetNetwork(
                                                    placeholder: AppAssets.placeholder,
                                                    image: uniqueAssignees.toList()[index].avatarUrl!,
                                                    fit: BoxFit.cover,
                                                  ): Image.asset(AppAssets.placeholder, fit: BoxFit.cover)),),
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
                            // Gap.k16.height,
                            // Gap.k2.height,
                            // Text(task.cage!.name!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gap.kSection.height,
                Text('Checklists', style: secondaryTextStyle(size: 14)),
                BlocConsumer<ChecklistCubit, ChecklistState>(listener: (context, state) {
                  // if(state is UpdateChecklistLoadingState){
                  //   showLoader(context);
                  // }
                  if (state is UpdateChecklistFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.replaceAll('Exception: ', ''))));
                    // hideLoader(context);
                  }
                  if (state is UpdateChecklistSuccessState) {
                    Fluttertoast.showToast(msg: 'Update ${state.checkList.title} success!');
                    // hideLoader(context);
                    // setState(() {
                    //   context.read<TaskCubit>().getTaskDetail(widget.taskId);
                    // });
                    setState(() {
                      context.read<TaskCubit>().getTaskDetail(widget.taskId);
                    });
                  }
                }, builder: (context, state) {
                  // if (state is ChecklistLoadingState) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  // if (state is ChecklistSuccessState) {
                  // var checklists = state.checkLists.checklists;
                  var checklists = task.checkLists!.where((c) => c.assignee!.id == UserRepo.user.id).toList();
                  checklists.sort((a, b) => a.order!.compareTo(b.order!));

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
                              child: Text(checklists[index].title!, style: primaryTextStyle(size: 14, weight: FontWeight.w500)),
                            ),
                            Flexible(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Checkbox(
                                      activeColor: primaryColor,
                                      value: checklists[index].status,
                                      onChanged: (value) {
                                        checklists[index].status = value;
                                        updateChecklistCubit.updateChecklistStatus(id: checklists[index].id!, status: value!);
                                        // setState(() {
                                        //   checklists[index] = {checklists[index].keys.first: !checklists[index].values.first};
                                        // });
                                      }),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       showDialog(
                                  //           context: context,
                                  //           builder: ((context) => AlertDialog(
                                  //                 title: Text(
                                  //                   'Note',
                                  //                   style: primaryTextStyle(),
                                  //                 ),
                                  //                 content: Column(
                                  //                   mainAxisSize: MainAxisSize.min,
                                  //                   children: [
                                  //                     Container(
                                  //                       padding: EdgeInsets.symmetric(horizontal: 16),
                                  //                       decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                                  //                       child: TextField(
                                  //                         // controller: TextEditingController(text: task.checkLists![index].note),
                                  //                         onChanged: (value) {
                                  //                           // task.checkLists![index].note = value;
                                  //                         },
                                  //                         decoration: InputDecoration(hintText: 'Enter note', border: InputBorder.none, hintStyle: secondaryTextStyle()),
                                  //                         maxLines: 5,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //                 actions: [
                                  //                   Container(
                                  //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  //                     decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8)),
                                  //                     child: Text('Save', style: primaryTextStyle(color: white, size: 14)),
                                  //                   ),
                                  //                   Gap.k8.width,
                                  //                   Container(
                                  //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  //                     decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                                  //                     child: Text('Cancel', style: primaryTextStyle(color: white, size: 14)),
                                  //                   ),
                                  //                 ],
                                  //               )));
                                  //     },
                                  //     icon: SvgPicture.asset(AppAssets.pen_to_square_svg, width: 16, height: 16, color: Colors.grey))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gap.k8.height,
                      itemCount: checklists.length);
                  // }
                  // return const SizedBox.shrink();
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
