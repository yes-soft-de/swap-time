import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/consts/keys.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:swaptime_flutter/module_notifications/service/notification_service/notification_service.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationsStateManager {
  final PublishSubject<NotificationState> _stateSubject = PublishSubject();
  Stream<NotificationState> get stateStream => _stateSubject.stream;

  final NotificationService _service;
  final SwapService _swapService;

  NotificationsStateManager(this._service, this._swapService) {
    FireNotificationService.onNotificationStream.listen((event) {
      getNotifications();
    });
  }

  void getNotifications() {
    _service.getNotifications().then((value) {
      if (value != null) {
        _stateSubject.add(NotificationStateLoadSuccess(value));
      } else {
        _stateSubject.add(NotificationStateLoading());
      }
    });
  }

  void updateSwap(NotificationModel swapItemModel) {
    swapItemModel.status = ApiKeys.KEY_SWAP_STATUS_ON_GOING;
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }

  void requestSwapComplete(NotificationModel swapItemModel, String myId) {
    swapItemModel.status = ApiKeys.KEY_SWAP_STATUS_PENDING_CONFIRM + '-' + myId;
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }

  void refuseSwapComplete(NotificationModel swapItemModel) {
    swapItemModel.status = ApiKeys.KEY_SWAP_STATUS_ON_GOING;
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }

  void setSwapAccepted(NotificationModel swapItemModel) {
    swapItemModel.status = ApiKeys.KEY_SWAP_STATUS_CONFIRMED;
    _swapService.updateSwap(swapItemModel).then((value) {
      getNotifications();
    });
  }
}
