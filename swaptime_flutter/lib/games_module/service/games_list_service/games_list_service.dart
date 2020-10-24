import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/manager/games_manager/games_manager.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

@provide
class GamesListService {
  final GamesManager _manager;
  final AuthService _authService;
  final MyProfileManager _profileManager;

  GamesListService(this._manager, this._authService, this._profileManager);

  Future<List<Games>> get getAvailableGames => _manager.getAvailableGames;

  Future<List<Games>> getUserGames(String userId) async {
    var games = <Games>[];
    var allGames = await getAvailableGames;
    allGames.forEach((element) {
      if (element.userID == userId) {
        games.add(element);
      }
    });

    return games;
  }

  Future<List<Games>> getMyGames() async {
    var userId = await _authService.userID;
    var games = <Games>[];
    var allGames = await getAvailableGames;
    allGames.forEach((element) {
      if (element.userID == userId) {
        games.add(element);
      }
    });

    return games;
  }

  Future<Games> getGameDetails(int gameId) async {
    if (gameId == -1) {
      return null;
    }
    List<Games> games = await getAvailableGames;
    if (games == null) {
      return null;
    }
    Games theGame;
    for (int i = 0; i < games.length; i++) {
      if (games[i].id == gameId) {
        theGame = games[i];
      }
    }

    for (int i = 0; i < theGame.comments.length; i++) {
      String userId = theGame.comments[i].userID;
      ProfileResponse profile = await _profileManager.getUserProfile(userId);
      theGame.comments[i].profile = profile;
    }

    await recordView(theGame.userID);

    return theGame;
  }

  Future<void> recordView(String userId) async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    print('Viewing ' + userId);
    if (userId != null) {
      try {
        store
            .collection('user_interactions')
            .doc('views')
            .collection(userId)
            .add({'msg': 'Hello'});
      } catch (e) {
        print(e);
      }
    }
  }

  Future<int> getViews(String userId) async {
    print('Requesting views');
    FirebaseFirestore store = FirebaseFirestore.instance;

    try {
      var result = await store
          .collection('user_interactions')
          .doc('views')
          .collection(userId)
          .get();
      print('Got ${result.size} views');
      return result.size;
    } catch (e) {
      return 0;
    }
  }
}
