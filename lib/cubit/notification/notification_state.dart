
import '../../domain/models/notifications.dart';

class NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationFaildState extends NotificationState {
  final String msg;
  NotificationFaildState({required this.msg});
}

class NotificationSuccessState extends NotificationState {
  final Notifications notifications;
  NotificationSuccessState({required this.notifications});
}

//Mark as read
class MarkAsReadNotificationState {}

class MarkAsReadNotificationLoadingState extends MarkAsReadNotificationState {}

class MarkAsReadNotificationFaildState extends MarkAsReadNotificationState {
  final String msg;
  MarkAsReadNotificationFaildState({required this.msg});
}

class MarkAsReadNotificationSuccessState extends MarkAsReadNotificationState {
  final int statusCode;
  MarkAsReadNotificationSuccessState({required this.statusCode});
}
