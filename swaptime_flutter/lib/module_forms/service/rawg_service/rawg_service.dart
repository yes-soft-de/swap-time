import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/manager/rawg_manager/rawg_manager.dart';
import 'package:swaptime_flutter/module_forms/model/search_model/search_model.dart';
import 'package:swaptime_flutter/module_forms/response/rawg_search/rawg_response.dart';
import 'package:swaptime_flutter/utils/rawg_helper/rawg_helper.dart';

@provide
class RawGService {
  final RawGManager _manager;

  RawGService(this._manager);

  Future<List<SearchModel>> search(String query) async {
    var response = await this._manager.search(query);
    List<SearchModel> searchList = [];
    response.results.forEach((element) {
      var platformList = getGamePlatformList(element.platforms);
      if (platformList != null) {
        searchList.add(SearchModel(
          name: element.name,
          image: element.backgroundImage,
          platforms: platformList,
        ));
      }
    });
    return searchList;
  }

  List<GamePlatform> getGamePlatformList(List<Platforms> platforms) {
    var platformList = <GamePlatform>[];
    platforms.forEach((element) {
      var platform = RawGHelper.getGamePlatform(element.platform.id);
      if (platform != null) platformList.add(platform);
    });
    return platformList;
  }
}

enum GamePlatform { PS5, PS4, PS3, XBOX_ONE, PC, SWITCH }
