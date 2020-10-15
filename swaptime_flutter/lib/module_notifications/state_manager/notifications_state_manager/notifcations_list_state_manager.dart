import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/service/notification_service/notification_service.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationsStateManager {
  final PublishSubject<NotificationState> _stateSubject = PublishSubject();
  Stream<NotificationState> get stateStream => _stateSubject.stream;

  final NotificationService _service;
  final SwapService _swapService;
  NotificationsStateManager(this._service, this._swapService);

  void getNotifications() {
    _service.getNotifications().then((value) {
      _stateSubject.add(NotificationStateLoadSuccess(value));
    });
  }

  void startSwap(String swapId) {}
}
