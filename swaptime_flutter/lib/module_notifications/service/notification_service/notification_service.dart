import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationService {
  final SwapService _swapService;

  NotificationService(
    this._swapService,
  );

  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];
    var swaps = await _swapService.getSwapRequests();
    for (int i = 0; i < swaps.length; i++) {
      var swap = swaps[i];
      notifications.add(NotificationModel(
        chatRoomId: swap.roomID,
        swapId: swap.id.toString(),
        userImage: swap.userTwoImage,
        gameOne: Games(
            mainImage: swap.swapItemOneImage,
            userName: swap.userOneName,
            id: swap.swapItemIdOne,
            userID: swap.userIdOne),
        gameTwo: Games(
            mainImage: swap.swapItemTwoImage,
            userName: swap.userTwoName,
            id: swap.swapItemIdTwo,
            userID: swap.userIdTwo),
        complete: swap.status == 'finished',
      ));
    }
    return notifications.reversed.toList();
  }
}
