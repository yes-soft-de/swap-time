import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';

class GameDetailsState {}

class GameDetailsStateLoadSuccess extends GameDetailsState {
  GameDetails details;
  GameDetailsStateLoadSuccess(this.details);
}

class GameDetailsStateInit extends GameDetailsState {}

class GameDetailsStateLoadError extends GameDetailsState {}
