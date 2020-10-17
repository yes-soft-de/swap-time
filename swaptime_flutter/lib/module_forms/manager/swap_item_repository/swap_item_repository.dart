import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';
import 'package:swaptime_flutter/module_forms/repository/swap_item_respository/swap_item_repository.dart';
import 'package:swaptime_flutter/module_forms/request/item_create_request/item_create_request.dart';

@provide
class SwapItemManager {
  final SwapItemRepository _repository;
  SwapItemManager(this._repository);

  Future<GameDetailsResponse> createItem(ItemCreateRequest request) {
    return _repository.createItem(request);
  }
}
