import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationState {}

class NotificationStateLoadSuccess extends NotificationState {
  List<NotificationModel> notifications;
  NotificationStateLoadSuccess(this.notifications);
}
