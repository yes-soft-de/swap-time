import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';
import 'package:swaptime_flutter/interaction_module/service/liked_service/liked_service.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';

@provide
class GamesListStateManager {
  final PublishSubject<GamesListState> _stateSubject =
      PublishSubject<GamesListState>();

  Stream<GamesListState> get stateStream => _stateSubject.stream;

  final GamesListService _service;
  final LikedService _likedService;
  final ProfileService _profileService;

  GamesListStateManager(
    this._service,
    this._likedService,
    this._profileService,
  );

  void getAvailableGames() {
    _stateSubject.add(GamesListStateLoading());
    _service.getAvailableGames.then((gamesList) {
      if (gamesList == null) {
        _stateSubject.add(GamesListStateLoadError());
      } else {
        var games = Set.of(gamesList);
        _stateSubject.add(GamesListStateLoadSuccess(List.of(games)));
      }
    });
  }

  Future<bool> love(String itemId, interactionId) {
    return _likedService.like(itemId, interactionId);
  }

  Future<bool> unLove(String itemId, [String interactionId]) {
    return _likedService.unLike(itemId, interactionId);
  }

  void getUserGames(String userId) {
    _service.getUserGames(userId).then((gamesList) {
      if (gamesList == null) {
        _stateSubject.add(GamesListStateLoadError());
      } else {
        var games = Set.of(gamesList);
        _stateSubject.add(GamesListStateLoadSuccess(List.of(games)));
      }
    });
  }

  Future<String> getUserName(String userId) async {
    ProfileResponse profile = await _profileService.getUserProfile(userId);
    return profile.userName;
  }
}
