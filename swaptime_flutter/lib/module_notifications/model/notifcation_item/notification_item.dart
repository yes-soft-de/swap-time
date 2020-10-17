import 'package:flutter/cupertino.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class NotificationModel {
  Games gameOne;
  Games gameTwo;
  String chatRoomId;
  String swapId;

  NotificationModel(
      {@required this.gameOne,
      @required this.gameTwo,
      @required this.chatRoomId,
      @required this.swapId});
}
