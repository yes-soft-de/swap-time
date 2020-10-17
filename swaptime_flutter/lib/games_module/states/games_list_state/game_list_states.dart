import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class GamesListState {}

class GamesListStateInit extends GamesListState {}

class GamesListStateLoadSuccess extends GamesListState {
  List<Games> games;

  GamesListStateLoadSuccess(this.games);
}

class GamesListStateLoadError extends GamesListState {}

class GamesListStateLoading extends GamesListState {}
