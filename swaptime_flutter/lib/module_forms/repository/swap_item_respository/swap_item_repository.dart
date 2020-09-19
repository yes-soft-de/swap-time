import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/module_forms/request/item_create_request/item_create_request.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';

@provide
class SwapItemRepository {
  final ApiClient _apiClient;
  SwapItemRepository(this._apiClient);

  Future<GameDetailsResponse> createItem(ItemCreateRequest request) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.API_GAMES, request.toJson());
    if (response == null) return null;
    return GameDetailsResponse.fromJson(response);
  }
}
