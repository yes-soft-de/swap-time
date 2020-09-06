import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/manager/rawg_manager/rawg_manager.dart';

@provide
class RawGService {
  RawGManager _manager;

  RawGService(this._manager);

  Future search(String query, GamePlatform platform) {
    int platformId = -1;

    switch (platform) {
      case GamePlatform.PS5:
        platformId = 1;
        break;
      case GamePlatform.PS4:
        platformId = 1;
        break;
      case GamePlatform.PS3:
        platformId = 1;
        break;
      case GamePlatform.XBOX:
        platformId = 1;
        break;
      case GamePlatform.PC:
        platformId = 1;
        break;
    }

    if (platformId > 0) {
      return this._manager.search(query, platformId);
    } else {
      return null;
    }
  }
}

enum GamePlatform { PS5, PS4, PS3, XBOX, PC }
