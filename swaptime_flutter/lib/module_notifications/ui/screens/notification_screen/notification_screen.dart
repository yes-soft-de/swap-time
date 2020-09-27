import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/my_profile/my_profile.dart';

@provide
class NotificationScreen extends StatefulWidget {
  final NotificationsStateManager _manager;
  final AuthService _authService;
  final MyProfileService _myProfileService;

  NotificationScreen(this._manager, this._myProfileService, this._authService);

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

    widget._authService.isLoggedIn.then((authorized) {
      if (authorized == false || authorized == null) {
        Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
        return;
      }
      widget._myProfileService.hasProfile().then((value) {
        if (value == false || value == null) {
          Navigator.of(context).pushNamed(ProfileRoutes.MY_ROUTE_PROFILE);
          return;
        }
        setState(() {});
      });
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
      return Flex(
        direction: Axis.vertical,
        children: getNotificationsList(state.notifications),
      );
    }
  }

  List<Widget> getNotificationsList(List<NotificationModel> notifications) {
    List<Widget> notCards = [];
    for (int i = 0; i < notifications.length; i++) {
      notCards.add(NotificationOnGoing(
        myGameUrl: notifications[i].ownerGameImageLink,
        theirGameUrl: notifications[i].swapperGameImageLink,
        theirName: notifications[i].ownerName,
        chatRoomId: notifications[i].chatRoomId,
      ));
    }
    return notCards;
  }
}
