import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_chat/args/chat_arguments.dart';
import 'package:swaptime_flutter/module_chat/chat_routes.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class NotificationOnGoing extends StatefulWidget {
  final Games gameOne;
  final Games gameTow;
  final String myId;
  final String chatRoomId;
  final String swapId;
  final bool finished;
  final bool shrink;
  final String userImage;
  final Function(Games) onChangeRequest;
  final Function(String) onSwapComplete;

  NotificationOnGoing({
    @required this.gameOne,
    @required this.gameTow,
    @required this.chatRoomId,
    @required this.myId,
    @required this.finished,
    @required this.swapId,
    @required this.onChangeRequest,
    @required this.onSwapComplete,
    @required this.userImage,
    this.shrink,
  });

  @override
  State<StatefulWidget> createState() => _NotificationState(
        this.gameOne,
        this.gameTow,
        this.chatRoomId,
        this.swapId,
        this.userImage,
      );
}

class _NotificationState extends State<NotificationOnGoing> {
  final Games gameOne;
  final Games gameTow;
  final String chatRoomId;
  final String swapId;
  final String userImage;

  _NotificationState(
    this.gameOne,
    this.gameTow,
    this.chatRoomId,
    this.swapId,
    this.userImage,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Card(
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  child: _getGamesRow(),
                ),
              ],
            ),
            widget.shrink == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(userImage ?? '')),
                                  shape: BoxShape.circle),
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              gameTow.userID == widget.myId
                                  ? gameOne.userName
                                  : gameTow.userName,
                            )
                          ],
                        ),
                        IconButton(
                            icon: chatRoomId != null && !widget.finished
                                ? Icon(
                                    Icons.chat,
                                    color: SwapThemeDataService.getPrimary(),
                                  )
                                : Icon(
                                    Icons.check,
                                    color: SwapThemeDataService.getPrimary(),
                                  ),
                            onPressed: () {
                              if (chatRoomId != null) {
                                Navigator.of(context)
                                    .pushNamed(ChatRoutes.chatRoute,
                                        arguments: ChatArguments(
                                          chatRoomId: chatRoomId,
                                          finished: widget.finished,
                                          gameOne: gameOne,
                                          gameTow: gameTow,
                                          swapId: swapId,
                                        ));
                              } else {
                                Fluttertoast.showToast(
                                  msg: S.of(context).pendingApproval,
                                );
                              }
                            })
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _getGamesRow() {
    return Stack(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _gameSelector(gameOne, gameTow.id != -1),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _gameSelector(gameTow, gameOne.id != -1),
            )
          ],
        ),
        widget.finished == true
            ? Positioned.fill(
                child: Container(
                  color: Colors.black45,
                  child: Center(
                      child: Text(
                    S.of(context).swapCompleted,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
                ),
              )
            : Positioned.fill(
                child: gameOne.id != -1 && gameTow.id != -1
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: SwapThemeDataService.getPrimary(),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              widget.onSwapComplete(swapId);
                            },
                          ),
                        ),
                      )
                    : Container(),
              )
      ],
    );
  }

  Widget _gameSelector(Games game, bool overlayEnabled) {
    return Stack(
      children: [
        Positioned.fill(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/logo.jpg',
            image: game.mainImage ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: overlayEnabled
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      widget.onChangeRequest(game);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: SwapThemeDataService.getAccent(),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
