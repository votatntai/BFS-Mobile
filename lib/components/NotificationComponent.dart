import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/notifications.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class NotificationComponent extends StatelessWidget {
  const NotificationComponent({
    super.key,
    required this.notification,
  });

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {

    Map<String, String> notificationIcon = {
    'Task': AppAssets.task,
    // 'Tournament': AppAssets.tournament,
  };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
        color: notification.isRead! ? white : primaryColor.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            notificationIcon[notification.type!]!,
            width: 50,
            height: 50,
          ),
          Gap.k16.width,
          Column(
            children: [
              SizedBox(width: context.width() * 0.7, child: Text(notification.title!, style: primaryTextStyle(size: 14), maxLines: 2, overflow: TextOverflow.ellipsis,)),
            ],
          ),
        ],
      ),
    );
  }
}