import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class GamesRepository {
  final ApiClient _client;
  GamesRepository(this._client);

  Future<List<Games>> getAvailableGames() async {
    var response = await _client.get(Urls.API_GAMES);
    return response ?? GamesResponse.fromJson(response).games;
  }

  Future<List<Games>> getUserGames(String userId) async {
    var response = await _client.get(Urls.API_USER_GAMES + '/$userId');
    return response ?? GamesResponse.fromJson(response).games;
  }
}
