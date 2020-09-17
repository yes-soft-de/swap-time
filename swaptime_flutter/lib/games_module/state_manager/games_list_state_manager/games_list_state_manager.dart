import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';

@provide
class GamesListStateManager {
  final PublishSubject<GamesListState> _stateSubject =
      PublishSubject<GamesListState>();

  Stream<GamesListState> get stateStream => _stateSubject.stream;

  final GamesListService _service;

  GamesListStateManager(this._service);

  void getAvailableGames() {
    _service.getAvailableGames.then((gamesList) {
      if (gamesList == null) {
        _stateSubject.add(GamesListStateLoadError());
      } else {
        _stateSubject.add(GamesListStateLoadSuccess(gamesList));
      }
    });
  }
}
