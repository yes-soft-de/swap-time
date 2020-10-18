import 'package:inject/inject.dart';
import 'package:swaptime_flutter/interaction_module/repository/interaction/interaction_repository.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';

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
}
