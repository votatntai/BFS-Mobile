import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

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
    HomeFragment(),
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
        child: Icon(Icons.home),
        backgroundColor: primaryColor,
        elevation: 15.0,
        onPressed: () {
          // Hành động khi nút được nhấn
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Đặt FAB ở giữa và neo vào BottomAppBar
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(), // Định hình cho notch xung quanh FAB
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
                      icon: Icon(Icons.home, color: primaryColor),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.calendar_today, color: primaryColor),
                      onPressed: () {}),
                  SizedBox(width: 48), // Tạo khoảng trống cho FAB
                  IconButton(
                      icon: Icon(Icons.file_copy, color: primaryColor),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.people, color: primaryColor),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
