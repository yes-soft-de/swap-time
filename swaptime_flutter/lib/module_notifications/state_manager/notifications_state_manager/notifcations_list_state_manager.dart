import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/service/notification_service/notification_service.dart';

@provide
class NotificationsStateManager {
  final PublishSubject<NotificationState> _stateSubject = PublishSubject();
  Stream<NotificationState> get stateStream => _stateSubject.stream;

  final NotificationService _service;
  NotificationsStateManager(this._service);

  void getNotifications() {
    _stateSubject.add(NotificationStateLoading());
    _service.getNotifications().then((value) {
      _stateSubject.add(NotificationStateLoadSuccess(value));
    });
  }

  void startSwap(String swapId) {}
}
