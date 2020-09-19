import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/manager/rawg_manager/rawg_manager.dart';

@provide
class RawGService {
  final RawGManager _manager;

  RawGService(this._manager);

  Future search(String query, GamePlatform platform) {
    int platformId = -1;

    switch (platform) {
      case GamePlatform.PS5:
        platformId = 187;
        break;
      case GamePlatform.PS4:
        platformId = 18;
        break;
      case GamePlatform.PS3:
        platformId = 16;
        break;
      case GamePlatform.XBOX_ONE:
        platformId = 1;
        break;
      case GamePlatform.PC:
        platformId = 4;
        break;
    }

    if (platformId > 0) {
      return this._manager.search(query, platformId);
    } else {
      return null;
    }
  }
}

enum GamePlatform { PS5, PS4, PS3, XBOX_ONE, PC }
