import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class LikedState {}

class LikedStateLoadSuccess extends LikedState {
  List<Games> games;
  LikedStateLoadSuccess(this.games);
}

class LikedStateLoadError extends LikedState {
  String errMsg;
  LikedStateLoadError(this.errMsg);
}

class LikedStateLoading extends LikedState {}
