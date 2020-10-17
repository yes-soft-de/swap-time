import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/games_module/games_routes.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_details/game_details.dart';

@provide
class GamesModule extends YesModule {
  final GameDetailsScreen _gameDetailsScreen;
  GamesModule(this._gameDetailsScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {GamesRoutes.ROUTE_GAME_DETAILS: (context) => _gameDetailsScreen};
  }
}
