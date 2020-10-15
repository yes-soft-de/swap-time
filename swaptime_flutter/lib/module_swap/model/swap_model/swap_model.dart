import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class SwapModel {
  String id;
  Games firstGame;
  Games secondGame;
  String roomId;

  SwapModel({this.id, this.firstGame, this.secondGame, this.roomId});
}
