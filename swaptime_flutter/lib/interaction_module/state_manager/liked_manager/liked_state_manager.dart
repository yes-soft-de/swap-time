import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/interaction_module/service/liked_service/liked_service.dart';
import 'package:swaptime_flutter/interaction_module/states/liked_states.dart';

@provide
class LikedStateManager {
  final PublishSubject<LikedState> _stateSubject = PublishSubject();

  Stream<LikedState> get stateStream => _stateSubject.stream;

  final LikedService _service;

  LikedStateManager(this._service);

  void getLikedGames() {
    _service.getLiked().then((value) {
      if (value == null) {
        _stateSubject.add(LikedStateLoadError('Error Loading Liked Games'));
      } else {
        _stateSubject.add(LikedStateLoadSuccess(value));
      }
    });
  }

  void onHate(String interactionId) {
    _service.unLike(interactionId).then((value) => getLikedGames());
  }
}
