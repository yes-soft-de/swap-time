import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationService {
  final SwapService _swapService;
  final AuthService _authService;

  NotificationService(
    this._swapService,
    this._authService,
  );

  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];
    var swaps = await _swapService.getSwapRequests();
    var myId = await _authService.userID;

    if (swaps == null) {
      return null;
    }

    for (int i = 0; i < swaps.length; i++) {
      var swap = swaps[i];
      notifications.add(NotificationModel(
        chatRoomId: swap.roomID,
        swapId: swap.id.toString(),
        userImage:
            myId == swap.userIdOne ? swap.userTwoImage : swap.userOneImage,
        gameOne: Games(
          mainImage: swap.swapItemOneImage,
          id: swap.swapItemIdOne,
          userName: swap.userTwoName,
          userID: swap.userIdTwo,
        ),
        gameTwo: Games(
            mainImage: swap.swapItemTwoImage,
            id: swap.swapItemIdTwo,
            userName: swap.userOneName,
            userID: swap.userIdOne),
        status: swap.status,
        date: DateTime.fromMillisecondsSinceEpoch(swap.date.timestamp * 1000),
        restrictedGamesUserOne: swap.gamesAllowedUserOne,
        restrictedGamesUserTwo: swap.gamesAllowedUserTwo,
      ));
    }
    notifications.sort((e1, e2) => e1.date.compareTo(e2.date));
    return notifications.toList();
  }
}
