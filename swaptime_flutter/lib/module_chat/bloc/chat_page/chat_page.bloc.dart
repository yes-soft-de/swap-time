import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_chat/model/chat/chat_model.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/service/notification_service/notification_service.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';

import '../../service/chat/char_service.dart';

@provide
class ChatPageBloc {
  static const STATUS_CODE_INIT = 1588;
  static const STATUS_CODE_EMPTY_LIST = 1589;
  static const STATUS_CODE_GOT_DATA = 1590;
  static const STATUS_CODE_BUILDING_UI = 1591;

  bool listening = false;

  String _chatRoomId;

  final ChatService _chatService;
  final SwapService _swapService;
  final NotificationService _notificationService;

  ChatPageBloc(
    this._chatService,
    this._swapService,
    this._notificationService,
  );

  final PublishSubject<Pair<int, List<ChatModel>>> _chatBlocSubject =
      new PublishSubject();

  Stream<Pair<int, List<ChatModel>>> get chatBlocStream =>
      _chatBlocSubject.stream;
  final PublishSubject<NotificationModel> _notificationUpdateSubject =
      PublishSubject();

  Stream<NotificationModel> get notificationStream =>
      _notificationUpdateSubject.stream;

  // We Should get the UUID of the ChatRoom, as such we should request the data here
  void getMessages(String chatRoomID) {
    _chatRoomId = chatRoomID;
    if (!listening) listening = true;
    _chatService.chatMessagesStream.listen((event) {
      _chatBlocSubject.add(Pair(STATUS_CODE_GOT_DATA, event));
    });
    _chatService.requestMessages(chatRoomID);
  }

  void sendMessage(String chatRoomID, String chat) {
    _chatService.sendMessage(chatRoomID, chat);
  }

  void dispose() {
    _chatBlocSubject.close();
  }

  void setNotificationComplete(NotificationModel swapItemModel) {
    swapItemModel.complete = true;
    _swapService.updateSwap(swapItemModel);
  }

  void checkSwapUpdates(String id) {
    _notificationService.getNotifications().then((value) {
      value.forEach((element) {
        if (element.chatRoomId == id) {
          _notificationUpdateSubject.add(NotificationModel(
            chatRoomId: id,
            complete: element.complete,
            swapId: element.swapId,
            gameOne: element.gameOne,
            gameTwo: element.gameTwo,
          ));
        }
      });
    });
  }
}
