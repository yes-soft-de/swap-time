import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class LikedService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final AuthService _authService;
  final GamesListService _gamesListService;

  LikedService(this._authService, this._gamesListService);

  Future<bool> isLiked(String itemId) async {
    String userId = await _authService.userID;
    DocumentSnapshot isLoved = await _fireStore
        .collection('likes')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .get();
    bool loved = isLoved.exists && isLoved.get('loved');
    return loved;
  }

  Future<bool> like(String itemId) async {
    log('loving: $itemId');
    String userId = await _authService.userID;
    await _fireStore
        .collection('likes')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .set({'loved': true});
    return true;
  }

  Future<bool> unLike(String itemId) async {
    log('hating: $itemId');
    String userId = await _authService.userID;
    await _fireStore
        .collection('likes')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .set({'loved': false});
    return false;
  }

  Future<List<GameDetails>> getLiked() async {
    String userId = await _authService.userID;
    QuerySnapshot data = await _fireStore
        .collection('likes')
        .doc(userId)
        .collection('items')
        .get();
    log(data.toString());
    List<GameDetails> items = [];
    for (int i = 0; i < data.docs.length; i++) {
      var game = await _gamesListService.getGameDetails(data.docs[i].id);
      items.add(game);
    }
    return items;
  }
}
