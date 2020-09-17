import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/repository/games_repository/games_repository.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

@provide
class GamesManager {
  final GamesRepository _repository;
  GamesManager(this._repository);

  Future<List<Games>> get getAvailableGames => _repository.getAvailableGames();
  Future<List<Games>> getUserGames(String userId) {
    return _repository.getUserGames(userId);
  }
}
