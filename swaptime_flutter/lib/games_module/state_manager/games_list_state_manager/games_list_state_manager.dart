import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';
import 'package:swaptime_flutter/liked_module/service/liked_service/liked_service.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/service/general_profile/general_profile.dart';

@provide
class GamesListStateManager {
  final PublishSubject<GamesListState> _stateSubject =
      PublishSubject<GamesListState>();

  Stream<GamesListState> get stateStream => _stateSubject.stream;

  final GamesListService _service;
  final LikedService _likedService;
  final GeneralProfileService _generalProfileService;

  GamesListStateManager(
    this._service,
    this._likedService,
    this._generalProfileService,
  );

  void getAvailableGames() {
    _service.getAvailableGames.then((gamesList) {
      if (gamesList == null) {
        _stateSubject.add(GamesListStateLoadError());
      } else {
        _stateSubject.add(GamesListStateLoadSuccess(gamesList));
      }
    });
  }

  Future<bool> isLoved(String itemId) {
    return _likedService.isLiked(itemId);
  }

  Future<bool> love(String itemId) {
    return _likedService.like(itemId);
  }

  Future<bool> unLove(String itemId) {
    return _likedService.unLike(itemId);
  }

  Future<String> getUserName(String userId) async {
    ProfileModel profile = await _generalProfileService.getUserDetails(userId);
    return profile.name;
  }
}
