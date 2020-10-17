import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/interaction_module/manager/interaction/interaction_manger.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class LikedService {
  final AuthService _authService;
  final GamesListService _gamesListService;
  final InteractionManager _interactionManager;

  LikedService(
    this._authService,
    this._gamesListService,
    this._interactionManager,
  );

  Future<bool> like(String itemId, String interactionId) async {
    log('loving: $itemId');
    bool signIn = await _authService.isLoggedIn;
    if (!signIn) {
      return null;
    }
    String userId = await _authService.userID;
    InteractionResponse response;
    if (interactionId != null) {
      print('Updating a New interaction');
      var request = InteractionRequest(
          userID: userId, swapItemID: itemId, type: 3, id: interactionId);
      response = await _interactionManager.updateInteraction(request);
    } else {
      var request =
          InteractionRequest(userID: userId, swapItemID: itemId, type: 3);
      response = await _interactionManager.postInteraction(request);
    }

    if (response == null) {
      return false;
    }

    int code = int.parse(response.statusCode);
    return code >= 200 && code < 400;
  }

  Future<bool> unLike(String itemId, [String interactionId]) async {
    log('hating: $itemId');
    bool signIn = await _authService.isLoggedIn;
    if (!signIn) {
      return null;
    }
    String userId = await _authService.userID;
    InteractionResponse response;
    if (interactionId != null) {
      var request = InteractionRequest(
          userID: userId, swapItemID: itemId, type: 2, id: interactionId);
      response = await _interactionManager.postInteraction(request);
    } else {
      var request =
          InteractionRequest(userID: userId, swapItemID: itemId, type: 3);
      response = await _interactionManager.updateInteraction(request);
    }

    if (response == null) {
      return false;
    }

    int code = int.parse(response.statusCode);
    return code >= 200 && code < 400;
  }

  Future<List<Games>> getLiked() async {
    String userId = await _authService.userID;
    List<Games> gamesList = await _gamesListService.getAvailableGames;
    List<Games> items = [];
    for (int i = 0; i < gamesList.length; i++) {
      if (gamesList[i].interaction.checkLoved) {
        items.add(gamesList[i]);
      }
    }
    return items;
  }
}
