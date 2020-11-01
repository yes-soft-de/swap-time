import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class GamesRepository {
  final ApiClient _client;
  final AuthService _authService;

  GamesRepository(this._client, this._authService);

  Future<List<Games>> getAvailableGames() async {
    String token = await _authService.getToken();
    Map<String, dynamic> response;
    if (token != null) {
      response = await _client.get(
        Urls.API_GAMES,
        headers: {'Authorization': 'Bearer ' + token},
      );
    } else {
      response = await _client.get(Urls.API_GAMES);
    }
    return response == null ? null : GamesResponse.fromJson(response).games;
  }

  Future<List<Games>> getUserGames(String userId) async {
    String token = await _authService.getToken();
    Map<String, dynamic> response;
    if (token != null) {
      response = await _client.get(Urls.API_USER_GAMES + '/$userId',
          headers: {'Authorization': 'Bearer ' + token});
    } else {
      response = await _client.get(Urls.API_USER_GAMES + '/$userId');
    }
    return response == null ? null : GamesResponse.fromJson(response).games;
  }

  Future<GameDetails> getGameDetails(int gameId) async {
    String token = await _authService.getToken();
    Map<String, dynamic> response;
    if (token != null) {
      response = await _client.get(
        Urls.API_GAME_BY_ID + '/$gameId',
        headers: {'Authorization': 'Bearer ' + token},
      );
    } else {
      response = await _client.get(Urls.API_GAME_BY_ID + '/$gameId');
    }
    return response == null
        ? null
        : GameDetailsResponse.fromJson(response).data;
  }
}
