import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';

@provide
class NotificationScreen extends StatefulWidget {
  final NotificationsStateManager _manager;
  NotificationScreen(this._manager);

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationState currentState;

  @override
  void initState() {
    super.initState();
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(currentState is NotificationStateLoadSuccess)) {
      widget._manager.getNotifications();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      NotificationStateLoadSuccess state = currentState;
      List<Widget> notifications = [];
      state.notifications.forEach((element) {
        notifications.add(NotificationOnGoing(
          myGameUrl: element.ownerGameImageLink,
          theirGameUrl: element.swapperGameImageLink,
          theirName: element.ownerName,
        ));
      });
      return Flex(
        direction: Axis.vertical,
        children: notifications,
      );
    }
  }
}
