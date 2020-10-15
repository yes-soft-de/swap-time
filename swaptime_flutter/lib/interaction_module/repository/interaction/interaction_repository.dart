import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/interaction_module/request/interaction/interaction.dart';
import 'package:swaptime_flutter/interaction_module/response/interaction/interaction_response.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class InteractionRepository {
  final ApiClient _apiClient;
  InteractionRepository(this._apiClient);

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
}
