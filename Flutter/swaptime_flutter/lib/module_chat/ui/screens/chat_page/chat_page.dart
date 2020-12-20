import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_chat/args/chat_arguments.dart';
import 'package:swaptime_flutter/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:swaptime_flutter/module_chat/model/chat/chat_model.dart';
import 'package:swaptime_flutter/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:swaptime_flutter/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_setter_widget/exchange_setter_widget.dart';
import 'package:swaptime_flutter/module_upload/service/image_upload/image_upload_service.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final AuthService _authService;
  final GamesListService _gamesListService;
  final SwapService _swapService;
  final ImageUploadService _uploadService;

  ChatPage(
    this._chatPageBloc,
    this._authService,
    this._gamesListService,
    this._swapService,
    this._uploadService,
  );

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  List<ChatBubbleWidget> chatsMessagesWidgets = [];

  Games gameToChange;
  String chatRoomId;
  NotificationModel activeNotification;

  bool initiated = false;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments is ChatArguments) {
      ChatArguments args = ModalRoute.of(context).settings.arguments;
      activeNotification = NotificationModel(
          gameOne: args.gameOne,
          gameTwo: args.gameTow,
          chatRoomId: args.chatRoomId,
          complete: args.finished,
          swapId: args.swapId);

      chatRoomId = args.chatRoomId;

      widget._chatPageBloc.notificationStream.listen((event) {
        activeNotification.gameOne = event.gameOne;
        activeNotification.gameTwo = event.gameTwo;
      });

      widget._chatPageBloc.startGamesUpdateCycle(args.swapId);
    } else {
      chatRoomId = ModalRoute.of(context).settings.arguments;
    }

    if (currentState == ChatPageBloc.STATUS_CODE_INIT) {
      print('Chat Room: ' + chatRoomId);
      widget._chatPageBloc.getMessages(chatRoomId);
    }

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            if (this.mounted) setState(() {});
          });
        }
      }
    });

    return Scaffold(
      body: Column(
        // direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppBar(
            title: Text(S.of(context).chatRoom),
          ),
          Column(
            children: [
              activeNotification.gameOne == null &&
                      activeNotification.gameTwo == null
                  ? Container()
                  : MediaQuery.of(context).viewInsets.bottom == 0
                      ? FutureBuilder(
                          future: widget._authService.userID,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return NotificationOnGoing(
                              shrink: true,
                              gameOne: activeNotification.gameOne,
                              gameTow: activeNotification.gameTwo,
                              swapId: activeNotification.swapId,
                              chatRoomId: chatRoomId,
                              myId: snapshot.data,
                              finished: activeNotification.complete,
                              onSwapComplete: (swap) {
                                widget._chatPageBloc.setNotificationComplete(
                                    NotificationModel(
                                        gameOne: activeNotification.gameOne,
                                        gameTwo: activeNotification.gameTwo,
                                        chatRoomId: chatRoomId,
                                        complete: activeNotification.complete,
                                        swapId: activeNotification.swapId));
                                activeNotification.complete = true;
                                setState(() {});
                              },
                              onChangeRequest: (game) {
                                // Change Games
                                gameToChange = game;
                                var dialog = Dialog(
                                  child: ExchangeSetterWidget(
                                    gamesListService: widget._gamesListService,
                                    userId: game != null ? game.userID : null,
                                  ),
                                );
                                showDialog(
                                        context: context,
                                        builder: (context) => dialog)
                                    .then((rawNewGame) {
                                  _updateSwapCard(rawNewGame);
                                });
                              },
                            );
                          },
                        )
                      : Container(),
            ],
          ),
          Expanded(
            child: chatsMessagesWidgets != null
                ? ListView(
                    children: chatsMessagesWidgets,
                    reverse: false,
                  )
                : Center(
                    child: Text(S.of(context).loading),
                  ),
          ),
          ChatWriterWidget(
            onMessageSend: (msg) {
              widget._chatPageBloc.sendMessage(chatRoomId, msg);
            },
            uploadService: widget._uploadService,
          ),
        ],
      ),
    );
  }

  void checkUpdates() {
    widget._chatPageBloc.checkSwapUpdates(chatRoomId);
    Future.delayed(Duration(seconds: 15), () {
      checkUpdates();
    });
  }

  void _updateSwapCard(Games newGame) {
    if (newGame != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).savingData)));
      if (gameToChange.userID == activeNotification.gameOne.userID) {
        activeNotification.gameOne = newGame;
        widget._swapService.updateSwap(activeNotification);
      } else {
        activeNotification.gameTwo = newGame;
        widget._swapService.updateSwap(activeNotification);
      }
    }
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    FirebaseAuth auth = await FirebaseAuth.instance;
    User user = auth.currentUser;
    chatList.forEach((element) {
      print(element.msg);
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == user.uid ? true : false,
        sentDate: element.sentDate,
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }
}
