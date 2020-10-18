import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_setter_widget/exchange_setter_widget.dart';

@provide
class NotificationScreen extends StatefulWidget {
  final NotificationsStateManager _manager;
  final AuthService _authService;
  final ProfileService _myProfileService;
  final GamesListService _gamesListService;
  final SwapService _swapService;

  NotificationScreen(
    this._manager,
    this._myProfileService,
    this._authService,
    this._gamesListService,
    this._swapService,
  );

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
      notCards.add(FutureBuilder(
        future: widget._authService.userID,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return NotificationOnGoing(
            gameOne: notifications[i].gameOne,
            gameTow: notifications[i].gameTwo,
            chatRoomId: notifications[i].chatRoomId,
            myId: snapshot.data,
            swapId: notifications[i].swapId,
            onChangeRequest: (game) {
              // Change Games
              Games oldGame = game;
              if (game == notifications[i].gameTwo) {
                oldGame = notifications[i].gameTwo;
              }
              var dialog = Dialog(
                child: ExchangeSetterWidget(
                  gamesListService: widget._gamesListService,
                  myId: snapshot.data,
                  userId: game != null ? game.userID : null,
                ),
              );
              showDialog(context: context, builder: (context) => dialog)
                  .then((rawNewGame) {
                Games newGame = rawNewGame;
                if (newGame != null) {
                  if (oldGame == notifications[i].gameOne) {
                    notifications[i].gameOne = newGame;
                  } else if (oldGame == notifications[i].gameTwo) {
                    notifications[i].gameTwo = newGame;
                  }

                  widget._swapService
                      .updateSwap(notifications[i])
                      .then((value) {
                    widget._manager.getNotifications();
                  });
                }
              });
            },
          );
        },
      ));
    }
    return notCards;
  }
}
