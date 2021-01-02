import 'package:flutter/cupertino.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class NotificationModel {
  Games gameOne;
  Games gameTwo;
  String chatRoomId;
  String swapId;
  String userImage;
  String status;
  DateTime date;
  List<int> restrictedGamesUserOne;
  List<int> restrictedGamesUserTwo;

  NotificationModel({
    @required this.gameOne,
    @required this.gameTwo,
    @required this.chatRoomId,
    @required this.status,
    @required this.date,
    @required this.userImage,
    @required this.swapId,
    @required this.restrictedGamesUserOne,
    @required this.restrictedGamesUserTwo,
  });
}
