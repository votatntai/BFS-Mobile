import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/fragments/CageFragment.dart';
import 'package:flutter_application_1/fragments/FoodFragment.dart';
import 'package:flutter_application_1/fragments/ProfileFragment.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../fragments/BirdFragment.dart';
import '../fragments/TaskFragment.dart';
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
    CageFragment(),
    BirdFragment(),
    const FoodFragment(),
    const ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
            color: Colors.black.withOpacity(
                0), // Container phải có màu nhưng có thể trong suốt
          ),
        ),
        widgetOption.elementAt(selectedItem)
      ]),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset(AppAssets.dove_svg,
            color: selectedItem == 2 ? white : primaryColor, width: 24, height: 24),
        backgroundColor: selectedItem == 2 ? primaryColor : primaryColor.withOpacity(0.2),
        elevation: 0,
        onPressed: () {
          onTapSelection(2);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Đặt FAB ở giữa và neo vào BottomAppBar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BottomAppBar(
          shape:
              const CircularNotchedRectangle(), // Định hình cho notch xung quanh FAB
          notchMargin: 10.0, // Khoảng cách giữa notch và FAB
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: SvgPicture.asset(AppAssets.list_check_svg,
                        color: selectedItem == 0 ? primaryColor : gray, height: 20),
                    onPressed: () {onTapSelection(0);}),
                IconButton(
                    icon: SvgPicture.asset(AppAssets.cage_svg,
                        color: selectedItem == 1 ? primaryColor : gray, height: 28),
                    onPressed: () {onTapSelection(1);}).paddingTop(4),
                const SizedBox(width: 48), // Tạo khoảng trống cho FAB
                IconButton(
                    icon: SvgPicture.asset(AppAssets.food_svg,
                        color: selectedItem == 3 ? primaryColor : gray, height: 20),
                    onPressed: () {onTapSelection(3);}),
                IconButton(
                    icon: SvgPicture.asset(AppAssets.user_svg,
                        color: selectedItem == 4 ? primaryColor : gray, height: 20),
                    onPressed: () {onTapSelection(4);}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
