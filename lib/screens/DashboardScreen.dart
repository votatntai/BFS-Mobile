import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/bird/bird_cubit.dart';
import 'package:flutter_application_1/fragments/ProfileFragment.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../fragments/BirdFragment.dart';
import '../fragments/HomeFragment.dart';
import '../widgets/Background.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, this.tabIndex});
  final int? tabIndex;
  static const String routeName = '/home';

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
    HomeFragment(),
    HomeFragment(),
    BlocProvider<BirdCubit>(create: (context) => BirdCubit(), child: BirdFragment()),
    HomeFragment(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomPaint(
          painter: DotPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
          child: Container(
            color: Colors.black.withOpacity(
                0), // Container phải có màu nhưng có thể trong suốt
          ),
        ),
        widgetOption.elementAt(selectedItem)
      ]),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset(AppAssets.dove_svg,
            color: whiteColor, width: 24, height: 24),
        backgroundColor: primaryColor,
        elevation: 15.0,
        onPressed: () {
          onTapSelection(2);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Đặt FAB ở giữa và neo vào BottomAppBar
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BottomAppBar(
          shape:
              CircularNotchedRectangle(), // Định hình cho notch xung quanh FAB
          notchMargin: 6.0, // Khoảng cách giữa notch và FAB
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: blueViolet.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset(AppAssets.list_check_svg,
                          color: primaryColor, width: 24, height: 24),
                      onPressed: () {onTapSelection(0);}),
                  IconButton(
                      icon: SvgPicture.asset(AppAssets.cage_svg,
                          color: primaryColor, width: 32, height: 32),
                      onPressed: () {onTapSelection(1);}).paddingTop(4),
                  SizedBox(width: 48), // Tạo khoảng trống cho FAB
                  IconButton(
                      icon: SvgPicture.asset(AppAssets.food_svg,
                          color: primaryColor, width: 24, height: 24),
                      onPressed: () {onTapSelection(3);}),
                  IconButton(
                      icon: SvgPicture.asset(AppAssets.user_svg,
                          color: primaryColor, width: 24, height: 24),
                      onPressed: () {onTapSelection(4);}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
