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

  Future<List<Games>> getUserGames(String userId) {
    return _manager.getUserGames(userId);
  }

  Future<List<Games>> getMyGames() async {
    var userId = await _authService.userID;
    return _manager.getUserGames(userId);
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

    return theGame;
  }
}
