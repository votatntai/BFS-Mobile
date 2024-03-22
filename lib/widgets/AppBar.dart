import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool? automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool? centerTitle;
  final double? elevation;
  final String? leadingIcon;
  final String? previousScreen;
  const MyAppBar({
    Key? key,
    required this.title,
    this.actions = const [], this.automaticallyImplyLeading, this.backgroundColor, this.titleColor, this.centerTitle, this.elevation = 0, this.leadingIcon, this.previousScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 16),),
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      titleTextStyle: TextStyle(color: titleColor ?? textPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold,),
      centerTitle: centerTitle ?? true,
      elevation: elevation,
      leading: leadingIcon != null ? Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: SvgPicture.asset(leadingIcon!, color: textPrimaryColor).onTap(() {
          if(previousScreen != null) {
            Navigator.pushReplacementNamed(context, previousScreen!);
          } else {
            Navigator.pop(context);
          }
        },).paddingSymmetric(vertical: 18),
      ).paddingLeft(16) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
