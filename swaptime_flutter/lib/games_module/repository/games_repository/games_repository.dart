import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class GamesRepository {
  final ApiClient _client;
  GamesRepository(this._client);

  Future<List<Games>> getAvailableGames() async {
    var response = await _client.get(Urls.API_GAMES);
    return response == null ? null : GamesResponse.fromJson(response).games;
  }

  Future<List<Games>> getUserGames(String userId) async {
    var response = await _client.get(Urls.API_USER_GAMES + '/$userId');
    return response == null ? null : GamesResponse.fromJson(response).games;
  }

  Future<GameDetails> getGameDetails(String gameId) async {
    var response = await _client.get(Urls.API_GAME_BY_ID + '/$gameId');
    return response == null
        ? null
        : GameDetailsResponse.fromJson(response).data;
  }
}
