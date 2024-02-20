import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool? automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool? centerTitle;
  final double? elevation;
  const MyAppBar({
    Key? key,
    required this.title,
    this.actions = const [], this.automaticallyImplyLeading, this.backgroundColor, this.titleColor, this.centerTitle, this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      titleTextStyle: TextStyle(color: titleColor ?? textPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold,),
      centerTitle: centerTitle ?? true,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
