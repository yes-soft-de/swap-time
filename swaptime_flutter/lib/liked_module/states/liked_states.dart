import 'package:swaptime_flutter/games_module/response/game_details/games_details.dart';

class LikedState {}

class LikedStateLoadSuccess extends LikedState {
  List<GameDetails> games;
  LikedStateLoadSuccess(this.games);
}

class LikedStateLoadError extends LikedState {
  String errMsg;
  LikedStateLoadError(this.errMsg);
}

class LikedStateLoading extends LikedState {}
