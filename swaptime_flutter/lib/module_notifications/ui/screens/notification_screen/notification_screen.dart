import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_setter_widget/exchange_setter_widget.dart';

@provide
class NotificationScreen extends StatefulWidget {
  final NotificationsStateManager _manager;
  final AuthService _authService;
  final ProfileService _myProfileService;
  final GamesListService _gamesListService;

  NotificationScreen(
    this._manager,
    this._myProfileService,
    this._authService,
    this._gamesListService,
  );

  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationState currentState;
  int viewLimit = 10;
  bool initiated = false;
  int activeIndex = -1;
  Games gameToChange;
  Games gameOne;
  Games gameTwo;

  List<NotificationModel> notifications;

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
    if (!initiated) {
      initiated = true;
      widget._manager.getNotifications();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (currentState is NotificationStateLoadSuccess) {
        NotificationStateLoadSuccess state = currentState;
        notifications = state.notifications;
        return FutureBuilder(
            future: widget._authService.userID,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return getNotificationsList(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            });
      } else if (currentState is NotificationStateLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Flex(
          direction: Axis.vertical,
          children: [
            Text(S.of(context).errorLoadingData),
            OutlinedButton(
              child: Text(S.of(context).retry),
              onPressed: () {
                widget._manager.getNotifications();
              },
            )
          ],
        );
      }
    }
  }

  Widget getNotificationsList(String myId) {
    List<Widget> notCards = [];
    for (int i = 0; i < notifications.length; i++) {
      notCards.add(NotificationOnGoing(
        gameOne: notifications[i].gameOne,
        gameTow: notifications[i].gameTwo,
        chatRoomId: notifications[i].chatRoomId,
        myId: myId,
        swapId: notifications[i].swapId,
        finished: notifications[i].complete,
        onSwapComplete: (swapId) {
          widget._manager.setNotificationComplete(notifications[i]);
        },
        onChangeRequest: (game) {
          // Setting the Scene
          activeIndex = i;
          gameOne = notifications[i].gameOne;
          gameTwo = notifications[i].gameTwo;
          gameToChange = notifications[i].gameOne;

          print(
              'Setter i $activeIndex Game One: ${gameOne} and Game Two: ${gameTwo.id.toString()}');

          if (game == notifications[i].gameTwo) {
            gameToChange = notifications[i].gameTwo;
          }

          var dialog = Dialog(
            child: ExchangeSetterWidget(
              gamesListService: widget._gamesListService,
              myId: myId,
              userId: game != null ? game.userID : null,
            ),
          );
          showDialog(context: context, builder: (context) => dialog)
              .then((rawNewGame) {
            _updateSwapCard(rawNewGame);
          });
        },
      ));
    }
    return Flex(
      direction: Axis.vertical,
      children: notCards,
    );
  }

  _updateSwapCard(Games rawNewGame) {
    Games newGame = rawNewGame;
    if (newGame != null) {
      print(
          'i $activeIndex Game One: ${gameOne.id} and Game Two: ${gameTwo.id}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).savingData)));
      if (gameToChange == notifications[activeIndex].gameOne) {
        notifications[activeIndex].gameOne = newGame;
        widget._manager.updateSwap(notifications[activeIndex]);
      } else {
        notifications[activeIndex].gameTwo = newGame;
        widget._manager.updateSwap(notifications[activeIndex]);
      }
    }
  }
}
