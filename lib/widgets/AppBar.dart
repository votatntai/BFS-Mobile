import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Color? leadingIconColor;
  final PreferredSize? bottom;
  final String? routeName;
  final Object? arguments;
  final bool isRefresh;
  const MyAppBar({
    super.key,
    required this.title,
    this.actions = const [], this.automaticallyImplyLeading, this.backgroundColor, this.titleColor, this.centerTitle, this.elevation = 0, this.leadingIcon, this.leadingIconColor, this.bottom, this.routeName, this.arguments, this.isRefresh = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      title: Text(title, style: const TextStyle(fontSize: 16),),
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      titleTextStyle: TextStyle(color: titleColor ?? textPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold,),
      centerTitle: centerTitle ?? true,
      elevation: elevation,
      bottom: bottom,
      leading: leadingIcon != null ?  SvgPicture.asset(leadingIcon!, color: leadingIconColor ?? textPrimaryColor).onTap(() {
          Navigator.pop(context, isRefresh);
        },).paddingSymmetric(vertical: 18) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
