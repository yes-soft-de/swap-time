import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';
import 'package:swaptime_flutter/interaction_module/response/liked_games/liked_games.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class InteractionRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  InteractionRepository(
    this._apiClient,
    this._authService,
  );

  Future<InteractionResponse> postInteraction(
      InteractionRequest request) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.API_INTERACTION, request.toJson());

    return response == null ? null : InteractionResponse.fromJson(response);
  }

  Future<InteractionResponse> updateInteraction(
      InteractionRequest request) async {
    Map<String, dynamic> response =
        await _apiClient.put(Urls.API_INTERACTION, request.toJson());

    return response == null ? null : InteractionResponse.fromJson(response);
  }

  Future<dynamic> deleteInteraction(String interactionId) async {
    String token = await _authService.getToken();
    if (token == null) {
      return null;
    }

    Map<String, dynamic> response = await _apiClient.delete(
      Urls.API_INTERACTION + interactionId,
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) {
      return null;
    }

    return LikedGames.fromJson(response);
  }

  Future<LikedGames> getLikedGames() async {
    String token = await _authService.getToken();
    if (token == null) {
      return null;
    }

    Map<String, dynamic> response = await _apiClient.get(
      Urls.API_USER_INTERACTION,
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) {
      return null;
    }

    return LikedGames.fromJson(response);
  }
}
