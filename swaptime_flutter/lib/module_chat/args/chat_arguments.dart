import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class ChatArguments {
  final String chatRoomId;
  final Games gameOne;
  final Games gameTow;
  final String swapId;

  ChatArguments({
    this.chatRoomId,
    this.gameOne,
    this.gameTow,
    this.swapId,
  });
}
