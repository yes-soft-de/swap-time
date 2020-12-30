import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/interaction_module/manager/interaction/interaction_manger.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';
import 'package:swaptime_flutter/interaction_module/response/liked_games/liked_games.dart';
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

    var game = await this._gamesListService.getGameDetails(int.parse(itemId));
    await this.recordUserLike(game.userID);

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

  Future<bool> unLike(String loveId) async {
    log('hating: $loveId');
    bool signIn = await _authService.isLoggedIn;
    if (!signIn) {
      return null;
    }
    dynamic response;
    if (loveId != null) {
      response = await _interactionManager.deleteInteraction(loveId);
    } else {
      return false;
    }

    if (response == null) {
      return false;
    }

    return response != null;
  }

  Future<List<LikedGameItem>> getLiked() async {
    var data = await _interactionManager.getLikedGames;
    return data.data;
  }

  Future<void> recordUserLike(String userId) async {
    FirebaseFirestore store = FirebaseFirestore.instance;

    try {
      await store
          .collection('user_interactions')
          .doc('likes')
          .collection(userId)
          .add({});
    } catch (e) {
      print(e);
    }
  }

  Future<int> getUserLikes(String userId) async {
    print('Requesting Likes');
    FirebaseFirestore store = FirebaseFirestore.instance;

    try {
      var result = await store
          .collection('user_interactions')
          .doc('likes')
          .collection(userId)
          .get();
      print('Got ${result.size} Likes');
      return result.size;
    } catch (e) {
      return 0;
    }
  }
}
