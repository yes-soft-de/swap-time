import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/keys.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_chat/args/chat_arguments.dart';
import 'package:swaptime_flutter/module_chat/chat_routes.dart';
import 'package:swaptime_flutter/module_home/states/notifications_state/notification_state.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_confirmation_pending/notification_confirmation_pending.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_confirmed/notification_confirmed.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_swap_start/notification_swap_start.dart';
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
  Games gameToChange;

  NotificationModel activeNotification;
  List<NotificationModel> notifications;

  @override
  void initState() {
    super.initState();

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
      widget._manager.stateStream.listen((event) {
        currentState = event;
        if (mounted) setState(() {});
      });
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
    if (notifications != null) {
      if (notifications.isNotEmpty) {
        notifications.forEach((n) {
          notCards.add(
            _getAppropriateNotificationCard(n, myId),
          );
        });
      }
    }
    return Flex(
      direction: Axis.vertical,
      children: notCards,
    );
  }

  Widget _getAppropriateNotificationCard(
    NotificationModel n,
    String myId,
  ) {
    if (n == null) {
      return Container();
    }
    if (n.status == null || n.status == ApiKeys.KEY_SWAP_STATUS_INIT) {
      return NotificationSwapStart(
        notification: n,
        myId: myId,
        onChangeRequest: (game) {
          _onChangeRequest(game, n);
        },
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_ON_GOING) {
      return NotificationOnGoing(
        notification: n,
        myId: myId,
        onSwapComplete: (swapId) {
          widget._manager.requestSwapComplete(n);
        },
        onChangeRequest: (game) {
          _onChangeRequest(game, n);
        },
        onChatRequested: () {
          var args = ChatArguments(
            chatRoomId: n.chatRoomId,
            notification: n,
          );

          Navigator.of(context).pushNamed(
            ChatRoutes.chatRoute,
            arguments: args,
          );
        },
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_PENDING_CONFIRM) {
      return NotificationSwapConfirmationPending(
        notification: n,
        myId: myId,
        onFinished: () {
          widget._manager.setSwapAccepted(n);
        },
        onRefuse: () {
          widget._manager.refuseSwapComplete(n);
        },
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_CONFIRMED) {
      return NotificationComplete(
        notification: n,
        myId: myId,
      );
    } else if (n.status == ApiKeys.KEY_SWAP_STATUS_REFUSED) {
      return NotificationComplete(
        notification: n,
        myId: myId,
      );
    } else {
      return Card(child: Text('Notification Status: ${n.status}'));
    }
  }

  void _onChangeRequest(game, n) {
    // The Game we want to change
    gameToChange = game;

    // Create the dialog for the question
    var dialog = Dialog(
      child: ExchangeSetterWidget(
        gamesListService: widget._gamesListService,
        userId: game.userID,
      ),
    );

    showDialog(context: context, builder: (context) => dialog)
        .then((rawNewGame) {
      activeNotification = n;
      _updateSwapCard(rawNewGame);
    });
  }

  void _updateSwapCard(Games rawNewGame) {
    Games newGame = rawNewGame;
    if (newGame != null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).savingData)));
      if (gameToChange.id == activeNotification.gameOne.id) {
        activeNotification.gameOne = newGame;
        widget._manager.updateSwap(activeNotification);
      } else {
        activeNotification.gameTwo = newGame;
        widget._manager.updateSwap(activeNotification);
      }
    }
  }
}
