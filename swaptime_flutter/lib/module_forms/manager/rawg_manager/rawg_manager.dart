import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/repository/rawg_repository/rawg_repository.dart';
import 'package:swaptime_flutter/module_forms/response/rawg_search/rawg_response.dart';

@provide
class RawGManager {
  final RawGRepository _repository;
  RawGManager(this._repository);

  Future<RawGResponse> search(String searchQuery, int platform) {
    return _repository.search(searchQuery, platform);
  }
}