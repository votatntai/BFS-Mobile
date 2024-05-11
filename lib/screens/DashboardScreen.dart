import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/staff/staff_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_cubit.dart';
import 'package:flutter_application_1/cubit/task/task_state.dart';
import 'package:flutter_application_1/fragments/FoodFragment.dart';
import 'package:flutter_application_1/fragments/MealPlanFragment.dart';
import 'package:flutter_application_1/fragments/ProfileFragment.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/staff/staff_state.dart';
import '../fragments/BirdFragment.dart';
import '../fragments/TaskFragment.dart';
import '../fragments/TicketFragment.dart';
import '../widgets/Background.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, this.tabIndex});
  final int? tabIndex;
  static const String routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
    if (widget.tabIndex != null) {
      selectedItem = widget.tabIndex!;
    }
  }

  void onTapSelection(int index) {
    setState(() => selectedItem = index);
  }

  List<Widget> widgetOption = <Widget>[
    TaskFragment(),
    const TicketFragment(),
    BirdFragment(),
    const MealPlanFragment(),
    const FoodFragment(),
    const ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [BlocProvider<StaffCubit>(create: (context) => StaffCubit()..getStaffInformation()), BlocProvider<TaskCubit>(create: (context) => TaskCubit()..getTasksStaff())],
        child: MultiBlocListener(
          listeners: [
            BlocListener<StaffCubit, StaffState>(
              listener: (context, state) {
                // if (state is StaffFailedState) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                // }
              },
            ),
            BlocListener<TaskCubit, TaskState>(listener: (context, state) {})
          ],
          child: Stack(children: [
            CustomPaint(
              painter: DotPainter(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
              child: Container(
                color: Colors.black.withOpacity(0), // Container phải có màu nhưng có thể trong suốt
              ),
            ),
            widgetOption.elementAt(selectedItem)
          ]),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(), // Định hình cho notch xung quanh FAB
          notchMargin: 10.0, // Khoảng cách giữa notch và FAB
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: SvgPicture.asset(AppAssets.list_check_svg, color: selectedItem == 0 ? primaryColor : gray, height: 20),
                    onPressed: () {
                      onTapSelection(0);
                    }),
                IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.ticket,
                      color: selectedItem == 1 ? primaryColor : gray,
                      width: 28,
                    ),
                    onPressed: () {
                      onTapSelection(1);
                    }).paddingTop(4),
                IconButton(
                    onPressed: () {
                      onTapSelection(2);
                    },
                    icon: SvgPicture.asset(AppAssets.dove_svg, color: selectedItem == 2 ? primaryColor : gray, height: 24)),
                IconButton(
                    icon: SvgPicture.asset(AppAssets.food_svg, color: selectedItem == 3 ? primaryColor : gray, height: 20),
                    onPressed: () {
                      onTapSelection(3);
                    }),
                IconButton(
                    icon: SvgPicture.asset(AppAssets.stock, color: selectedItem == 4 ? primaryColor : gray, height: 20),
                    onPressed: () {
                      onTapSelection(4);
                    }),
                IconButton(
                    icon: SvgPicture.asset(AppAssets.user_svg, color: selectedItem == 5 ? primaryColor : gray, height: 20),
                    onPressed: () {
                      onTapSelection(5);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
