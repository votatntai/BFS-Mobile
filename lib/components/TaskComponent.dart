import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/tasks.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class TaskComponent extends StatelessWidget {
  final Task task;
  const TaskComponent({
    super.key, required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(task.title!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Gap.k8.height,
        Text(task.cage!.species!.name!,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textGrayColor)),
        Gap.k4.height,
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.clock_svg,
                    width: 16, height: 16, color: primaryColor.withOpacity(0.5)),
                    Gap.k8.width,
                Text(DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(task.deadLine!)),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor.withOpacity(0.5))),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: task.status == 'Done' ? forestGreen.withOpacity(0.3) : task.status == 'In progress' ? goldenRod.withOpacity(0.3) : task.status == 'To do' ? dodgerBlue.withOpacity(0.3) : slateBlue.withOpacity(0.3),
                  borderRadius:
                      BorderRadius.circular(10)),
              child: Text(task.status!, style: TextStyle(
                color: task.status == 'Done' ? forestGreen : task.status == 'In progress' ? goldenRod : task.status == 'To do' ? dodgerBlue : slateBlue,
                fontWeight: FontWeight.w500,
              )),
            ),
          ],
        ),
        
      ]),
    ).onTap((){
      Navigator.pushNamed(context, '/task-detail', arguments: task.id);
    });
  }
}
