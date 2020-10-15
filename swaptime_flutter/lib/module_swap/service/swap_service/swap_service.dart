import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_swap/manager/swap/swap_manager.dart';
import 'package:swaptime_flutter/module_swap/model/swap_model/swap_model.dart';
import 'package:swaptime_flutter/module_swap/request/swap_request/swap_request.dart';
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
    var swapResponse = await _swapManager.createSwap(CreateSwapRequest(
        userIdOne: uid,
        userIdTwo: gameOwnerId,
        swapItemIdOne: gameId,
        date: DateTime.now().toIso8601String(),
        roomID: Uuid().v1()));

    if (swapResponse == null) {
      return null;
    }

    return SwapModel();
  }

  Future<SwapModel> startSwap(String swapId, String swapItemId) async {}

  Future<List<SwapModel>> getSwapRequests() async {
    String uid = await _authService.userID;
    SwapListResponse response = await _swapManager.getMySwaps(uid);

    List<SwapModel> swaps = [];

    for (int i = 0; i < response.data.length; i++) {
      SwapModel result = SwapModel();
      var firstGameId = response.data[i].swapItemIdOne;
      if (firstGameId != null) {
        Games gameOne = await _gamesListService.getGameDetails(firstGameId);
        result.firstGame = gameOne;
      }

      var secondGameId = response.data[i].swapItemIdTwo;
      if (secondGameId != null) {
        Games gameTwo = await _gamesListService.getGameDetails(secondGameId);
        result.secondGame = gameTwo;
      }

      result.roomId = result.roomId;
      result.id = result.id;

      swaps.add(result);
    }

    return swaps;
  }

  Future<bool> isRequested(int gameId) async {
    String uid = await _authService.userID;
    var swaps = await _swapManager.getMySwaps(uid);
    if (swaps == null) {
      return false;
    }
    for (int i = 0; i < swaps.data.length; i++) {
      if (swaps.data[i].swapItemIdTwo == gameId ||
          swaps.data[i].swapItemIdTwo == gameId) {
        return true;
      }
    }

    return false;
  }
}
