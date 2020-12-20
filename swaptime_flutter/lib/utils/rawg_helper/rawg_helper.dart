import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';

class RawGHelper {
  static int getGamePlatformApiKey(GamePlatform gamePlatform) {
    switch (gamePlatform) {
      case GamePlatform.PS5:
        return 187;
      case GamePlatform.PS4:
        return 18;
      case GamePlatform.PS3:
        return 16;
      case GamePlatform.XBOX_ONE:
        return 1;
      case GamePlatform.PC:
        return 4;
      case GamePlatform.SWITCH:
        return 7;
      default:
        return -1;
    }
  }

  static GamePlatform getGamePlatform(int platformId) {
    switch (platformId) {
      case 187:
        return GamePlatform.PS5;
        break;
      case 18:
        return GamePlatform.PS4;
        break;
      case 16:
        return GamePlatform.PS3;
        break;
      case 1:
        return GamePlatform.XBOX_ONE;
        break;
      case 7:
        return GamePlatform.SWITCH;
      case 4:
        return GamePlatform.PC;
        break;
      default:
        return null;
    }
  }
}
