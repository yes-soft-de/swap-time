import 'package:inject/inject.dart';
import 'package:swaptime_flutter/interaction_module/repository/interaction/interaction_repository.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';
import 'package:swaptime_flutter/interaction_module/response/liked_games/liked_games.dart';

@provide
class InteractionManager {
  final InteractionRepository _repository;
  InteractionManager(this._repository);

  Future<InteractionResponse> postInteraction(InteractionRequest request) {
    return _repository.postInteraction(request);
  }

  Future<InteractionResponse> updateInteraction(InteractionRequest request) {
    return _repository.updateInteraction(request);
  }

  Future<dynamic> deleteInteraction(String interactionId) =>
      _repository.deleteInteraction(interactionId);

  Future<LikedGames> get getLikedGames => _repository.getLikedGames();
}
