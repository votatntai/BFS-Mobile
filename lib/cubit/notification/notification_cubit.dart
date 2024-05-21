import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../domain/repositories/notification_repo.dart';
import '../../utils/constants.dart';
import '../../utils/get_it.dart';
import 'notification_state.dart';

final NotificationRepo _notificationRepo = getIt<NotificationRepo>();

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState());

  Future<void> getNotifications({int? pageNumber, int? pageSize}) async {
    try {
      emit(NotificationLoadingState());
      var notifications = await _notificationRepo.getNotifications(pageNumber: pageNumber, pageSize: pageSize);
      await setValue(AppConstant.NOTI_COUNT, notifications.notifications!.where((noti) => noti.isRead == false).length);
      emit(NotificationSuccessState(notifications: notifications));
    } on Exception catch (e) {
      emit(NotificationFaildState(msg: e.toString()));
    }
  }
}

class MarkAsReadNotificationCubit extends Cubit<MarkAsReadNotificationState> {
  MarkAsReadNotificationCubit() : super(MarkAsReadNotificationState());

  Future<void> markAsRead({required String notificationId}) async {
    try {
      emit(MarkAsReadNotificationLoadingState());
      var statusCode = await _notificationRepo.markAsRead(notificationId: notificationId);
      emit(MarkAsReadNotificationSuccessState(statusCode: statusCode));
    } on Exception catch (e) {
      emit(MarkAsReadNotificationFaildState(msg: e.toString()));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      emit(MarkAsReadNotificationLoadingState());
      if (await _notificationRepo.markAllAsRead() == 200) {
        await setValue(AppConstant.NOTI_COUNT, 0);
        emit(MarkAsReadNotificationSuccessState(statusCode: 200));
      }
    } on Exception catch (e) {
      emit(MarkAsReadNotificationFaildState(msg: e.toString()));
    }
  }
}
