import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

class TaskDetailScreen extends StatefulWidget {
  static const routeName = '/task-detail';
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String status = 'progress';
  List<Map<String, bool>> checklists = [{'Cho chim A ăn 1 lượng cám 3g': false}, {'Kiểm tra tình trạng chim B': false}, {'Đo nhiệt độ chim C': false}, {'Đo nhiệt độ chim Czzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz': false}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Task Detail',
        leadingIcon: AppAssets.angle_left_svg,
      ),
      body: Background(
          widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cho ăn và uống', style: boldTextStyle(size: 20)),
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
                          SvgPicture.asset(AppAssets.users_svg,
                              width: 16, height: 16, color: Colors.grey),
                          Gap.k8.width,
                          Text('Assignees',
                              style: secondaryTextStyle(size: 14)),
                        ],
                      ),
                      Gap.k16.height,
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.circle_half_stroke_svg,
                              height: 16, color: Colors.grey),
                          Gap.k8.width,
                          Text('Status', style: secondaryTextStyle(size: 14)),
                        ],
                      ),
                      Gap.k16.height,
                      Gap.k2.height,
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.clock_svg,
                              height: 16, color: Colors.grey),
                          Gap.k8.width,
                          Text('Deadline', style: secondaryTextStyle(size: 14)),
                        ],
                      ),
                      Gap.k16.height,
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.dove_svg,
                              height: 16, color: Colors.grey),
                          Gap.k8.width,
                          Text('Species', style: secondaryTextStyle(size: 14)),
                        ],
                      ),
                      14.height,
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.cage_svg,
                              height: 24, color: Colors.grey),
                          Gap.k8.width,
                          Text('Cage', style: secondaryTextStyle(size: 14)),
                        ],
                      ),
                      12.height,
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.hand_holding_medical_svg,
                              height: 16, color: Colors.grey),
                          Gap.k8.width,
                          Text('Care mode',
                              style: secondaryTextStyle(size: 14)),
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
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24)),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              'assets/images/avatar1.jpeg',
                                              fit: BoxFit.cover,
                                            ))),
                                    Gap.k8.width,
                                    Text('Nguyễn Thị Anh',
                                        style: primaryTextStyle(
                                            weight: FontWeight.w500, size: 14)),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Gap.k8.width,
                            itemCount: 3),
                      ),
                      Gap.k8.height,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: status == 'todo'
                                      ? dodgerBlue.withOpacity(0.3)
                                      : grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppAssets.circle_svg,
                                      width: 14,
                                      height: 14,
                                      color:
                                          status == 'todo' ? dodgerBlue : grey),
                                  Gap.k4.width,
                                  Text('To do',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: status == 'todo'
                                              ? dodgerBlue
                                              : grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ).onTap(() {
                              setState(() {
                                status = 'todo';
                              });
                            }),
                            Gap.k8.width,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: status == 'progress'
                                      ? goldenRod.withOpacity(0.3)
                                      : grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      AppAssets.circle_half_stroke_svg,
                                      width: 14,
                                      height: 14,
                                      color: status == 'progress'
                                          ? goldenRod
                                          : grey),
                                  Gap.k4.width,
                                  Text('In progress',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: status == 'progress'
                                              ? goldenRod
                                              : grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ).onTap(() {
                              setState(() {
                                status = 'progress';
                              });
                            }),
                            Gap.k8.width,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: status == 'done'
                                      ? forestGreen.withOpacity(0.3)
                                      : grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppAssets.circle_check_svg,
                                      width: 14,
                                      height: 14,
                                      color: status == 'done'
                                          ? forestGreen
                                          : grey),
                                  Gap.k4.width,
                                  Text('Done',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: status == 'done'
                                              ? forestGreen
                                              : grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ).onTap(() {
                              setState(() {
                                status = 'done';
                              });
                            }),
                          ],
                        ),
                      ),
                      Gap.k16.height,
                      Text('13/03/2024',
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w500)),
                      Gap.k16.height,
                      Text('Chào mào',
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w500)),
                      Gap.k16.height,
                      Gap.k2.height,
                      Text('Xxxxxx',
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w500)),
                      Gap.k16.height,
                      Text('Xxxxxx',
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Gap.kSection.height,
          Text('Checklists', style: secondaryTextStyle(size: 14)),
          ListView.separated(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 7,
                      child: Text(checklists[index].keys.first,
                          style: primaryTextStyle(
                              size: 14, weight: FontWeight.w500)),
                    ),

                    Flexible(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                              activeColor: primaryColor,
                              value: checklists[index].values.first,
                              onChanged: (context) {
                                setState(() {
                                  checklists[index] = {checklists[index].keys.first: !checklists[index].values.first};
                                });
                              }),
                              IconButton(onPressed: (){}, icon: SvgPicture.asset(AppAssets.pen_to_square_svg, width: 16, height: 16, color: Colors.grey))
                        ],
                      ),
                    ),
                        
                  ],
                );
              },
              separatorBuilder: (context, index) => Gap.k8.height,
              itemCount: checklists.length),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 16)),
    );
  }
}
