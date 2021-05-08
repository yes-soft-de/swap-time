import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class GameDetailsState {}

class GameDetailsStateLoadSuccess extends GameDetailsState {
  Games details;
  bool isLoggedId;
  GameDetailsStateLoadSuccess(this.details, this.isLoggedId);
}

class GameDetailsStateInit extends GameDetailsState {}

class GameDetailsStateLoadError extends GameDetailsState {}
