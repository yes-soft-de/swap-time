import 'package:flutter/cupertino.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class ChatArguments {
  final String chatRoomId;
  final Games gameOne;
  final Games gameTow;
  final String swapId;
  final bool finished;

  ChatArguments({
    @required this.chatRoomId,
    @required this.gameOne,
    @required this.gameTow,
    @required this.swapId,
    @required this.finished,
  });
}
