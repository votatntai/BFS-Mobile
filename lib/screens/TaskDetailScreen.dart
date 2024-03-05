import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/AppBar.dart';

import '../utils/app_assets.dart';

class TaskDetailScreen extends StatefulWidget {
  static const routeName = '/task-detail';
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(title: 'Task Detail', leadingIcon: AppAssets.angle_left_svg,),);
  }
}