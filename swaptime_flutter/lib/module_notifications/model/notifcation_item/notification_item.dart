import 'package:flutter/cupertino.dart';

class NotificationModel {
  String swapperGameImageLink;
  String ownerGameImageLink;
  String ownerName;
  String chatRoomId;
  String swapId;

  NotificationModel(
      {@required this.swapperGameImageLink,
      @required this.ownerGameImageLink,
      @required this.ownerName,
      @required this.chatRoomId,
      @required this.swapId});
}
