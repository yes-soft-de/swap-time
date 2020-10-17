import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';

class IconHelper {
  static Widget getIcon(GamePlatform element) {
    switch (element) {
      case GamePlatform.PS5:
        return SvgPicture.asset('assets/images/ps5.svg');
        break;
      case GamePlatform.PS4:
        return SvgPicture.asset('assets/images/ps4.svg');
        break;
      case GamePlatform.PS3:
        return SvgPicture.asset('assets/images/ps3.svg');
        break;
      case GamePlatform.XBOX_ONE:
        return SvgPicture.asset('assets/images/xbox.svg');
        break;
      case GamePlatform.PC:
        return SvgPicture.asset('assets/images/pc.svg');
        break;
      case GamePlatform.SWITCH:
        return SvgPicture.asset('assets/images/switch.svg');
        break;
      default:
        return SvgPicture.asset('assets/images/question.svg');
    }
  }
}
