import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';

@provide
class GameDetailsManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  final GamesListService _gamesListService;
  GameDetailsManager(this._gamesListService);

  void getGameDetails(int gameId) {
    _gamesListService.getGameDetails(gameId).then((value) {
      if (value == null) {
        _stateSubject.add(GameDetailsStateLoadError());
      } else {
        _stateSubject.add(GameDetailsStateLoadSuccess(value));
      }
    });
  }
}
