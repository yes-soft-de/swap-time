import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

@provide
class NotificationService {
  final AuthService _authService;
  final SwapService _swapService;
  final GamesListService _gamesListService;

  NotificationService(
    this._authService,
    this._gamesListService,
    this._swapService,
  );

  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];
    var swaps = await _swapService.getSwapRequests();
    for (int i = 0; i < swaps.length; i++) {
      var swap = swaps[i];
      Games ownerGameDetails = swap.firstGame;
      Games swapperGameDetails = swap.secondGame;
      print('${swap.roomId}');
      notifications.add(NotificationModel(
        chatRoomId: swap.roomId,
        swapId: swap.id,
        gameOne: ownerGameDetails,
        gameTwo: swapperGameDetails,
      ));
    }
    return notifications;
  }
}
