import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_swap/manager/swap/swap_manager.dart';
import 'package:swaptime_flutter/module_swap/model/swap_model/swap_model.dart';
import 'package:swaptime_flutter/module_swap/request/swap_request/swap_request.dart';
import 'package:swaptime_flutter/module_swap/request/update_swap/update_swap_response.dart';
import 'package:swaptime_flutter/module_swap/response/swap_list/swap_list_response.dart';
import 'package:uuid/uuid.dart';

@provide
class SwapService {
  final AuthService _authService;
  final SwapManager _swapManager;
  final GamesListService _gamesListService;

  SwapService(
    this._authService,
    this._swapManager,
    this._gamesListService,
  );

  Future<SwapModel> createSwap(String gameOwnerId, int gameId) async {
    String uid = await _authService.userID;

    if (uid == null) {
      throw ('Unauthorized');
    }

    var swapResponse = await _swapManager.createSwap(
      CreateSwapRequest(
          userIdOne: uid,
          userIdTwo: gameOwnerId,
          swapItemIdOne: gameId,
          swapItemIdTwo: -1,
          date: DateTime.now().toIso8601String(),
          roomID: Uuid().v1()),
    );

    if (swapResponse == null) {
      return null;
    }

    return SwapModel();
  }

  Future<SwapModel> updateSwap(NotificationModel swapItemModel) async {
    print(
        'Game One: ${swapItemModel.gameOne.id} and Game Two: ${swapItemModel.gameTwo.id}');
    UpdateSwapRequest updateSwapRequest = UpdateSwapRequest(
      id: swapItemModel.swapId,
      date: DateTime.now().toIso8601String(),
      userIdOne:
          swapItemModel.gameOne != null ? swapItemModel.gameOne.userID : null,
      userIdTwo:
          swapItemModel.gameTwo != null ? swapItemModel.gameTwo.userID : null,
      swapItemIdOne:
          swapItemModel.gameOne != null ? swapItemModel.gameOne.id : null,
      swapItemIdTwo:
          swapItemModel.gameTwo != null ? swapItemModel.gameTwo.id : null,
      roomID: swapItemModel.chatRoomId,
    );
    var result = await _swapManager.updateSwap(updateSwapRequest);

    return result != null ? SwapModel() : null;
  }

  Future<List<SwapListItem>> getSwapRequests() async {
    String uid = await _authService.userID;
    var result = await _swapManager.getMySwaps(uid);
    var swapMap = <String, SwapListItem>{};
    if (result != null) {
      result.data.forEach((element) {
        if (swapMap[element.roomID] == null) {
          swapMap[element.roomID] = element;
        }
      });
    } else {
      return [];
    }
    return swapMap.values.toList();
  }

  Future<bool> isRequested(int gameId) async {
    print('Requesting game ID: ' + gameId.toString());
    String uid = await _authService.userID;
    var swaps = await _swapManager.getMySwaps(uid);
    if (swaps == null) {
      return false;
    }
    for (int i = 0; i < swaps.data.length; i++) {
      if (swaps.data[i].swapItemIdOne == gameId ||
          swaps.data[i].swapItemIdTwo == gameId) {
        return true;
      }
    }
    return false;
  }
}
