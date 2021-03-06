import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/service/notification_service/notification_service.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationsStateManager {
  bool enabled = true;

  final PublishSubject<NotificationState> _stateSubject = PublishSubject();

  Stream<NotificationState> get stateStream {
    enabled = true;
    return _stateSubject.stream;
  }

  final NotificationService _service;
  final SwapService _swapService;

  NotificationsStateManager(this._service, this._swapService);

  void getNotifications() {
    if (enabled) {
      _stateSubject.add(NotificationStateLoading());
      _service.getNotifications().then((value) {
        if (value != null) {
          _stateSubject.add(NotificationStateLoadSuccess(value));
        }
      });
    }
  }

  void startNotificationRefreshCycle() {
    Future.delayed(Duration(seconds: 15), () {
      if (enabled) {
        _service.getNotifications().then((value) {
          _stateSubject.add(NotificationStateLoadSuccess(value));
        });
        startNotificationRefreshCycle();
      }
    });
  }

  void updateSwap(NotificationModel swapItemModel) {
    _stateSubject.add(NotificationStateLoading());
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }

  void setNotificationComplete(NotificationModel swapItemModel) {
    swapItemModel.complete = true;
    _stateSubject.add(NotificationStateLoading());
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }

  void dispose() {
    enabled = false;
  }
}
