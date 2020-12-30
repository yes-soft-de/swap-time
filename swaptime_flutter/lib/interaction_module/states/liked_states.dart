import 'package:swaptime_flutter/interaction_module/response/liked_games/liked_games.dart';

class LikedState {}

class LikedStateLoadSuccess extends LikedState {
  List<LikedGameItem> games;
  LikedStateLoadSuccess(this.games);
}

class LikedStateLoadError extends LikedState {
  String errMsg;
  LikedStateLoadError(this.errMsg);
}

class LikedStateLoading extends LikedState {}
