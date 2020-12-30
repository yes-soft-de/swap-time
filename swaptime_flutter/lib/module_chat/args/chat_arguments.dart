import 'package:flutter/cupertino.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';

class ChatArguments {
  final String chatRoomId;
  final NotificationModel notification;

  ChatArguments({
    @required this.chatRoomId,
    @required this.notification,
  });
}
