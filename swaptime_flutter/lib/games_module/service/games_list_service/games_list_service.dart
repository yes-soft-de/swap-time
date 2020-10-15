import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/manager/games_manager/games_manager.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class GamesListService {
  final GamesManager _manager;
  final AuthService _authService;
  GamesListService(this._manager, this._authService);

  Future<List<Games>> get getAvailableGames => _manager.getAvailableGames;

  Future<List<Games>> getUserGames(String userId) {
    return _manager.getUserGames(userId);
  }

  Future<List<Games>> getMyGames() async {
    var userId = await _authService.userID;
    return _manager.getUserGames(userId);
  }

  Future<Games> getGameDetails(int gameId) async {
    List<Games> games = await getAvailableGames;
    for (int i = 0; i < games.length; i++) {
      if (games[i].id == gameId) {
        return games[i];
      }
    }
    return null;
  }
}
