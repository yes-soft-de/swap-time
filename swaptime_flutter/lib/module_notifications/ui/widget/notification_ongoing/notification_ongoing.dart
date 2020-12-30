import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class NotificationOnGoing extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final Function(Games) onChangeRequest;
  final Function(String) onSwapComplete;
  final Function() onChatRequested;
  final bool shrink;

  NotificationOnGoing({
    @required this.notification,
    @required this.myId,
    this.onChangeRequest,
    this.onChatRequested,
    this.onSwapComplete,
    this.shrink,
  });

  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationOnGoing> {
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
            Padding(
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
                            image: NetworkImage(
                                widget.notification.userImage ?? ''),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 16,
                      ),
                      Text(
                        widget.notification.gameTwo.userID == widget.myId
                            ? widget.notification.gameOne.userName
                            : widget.notification.gameTwo.userName,
                      )
                    ],
                  ),
                  IconButton(
                      icon: widget.notification.chatRoomId != null
                          ? Icon(
                              Icons.chat,
                              color: SwapThemeDataService.getPrimary(),
                            )
                          : Icon(
                              Icons.check,
                              color: SwapThemeDataService.getPrimary(),
                            ),
                      onPressed: () {
                        if (widget.notification.chatRoomId != null) {
                          widget.onChatRequested();
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
              child: _gameSelector(widget.notification.gameOne),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _gameSelector(widget.notification.gameTwo),
            )
          ],
        ),
        Positioned.fill(
          child: widget.notification.gameOne.id != -1 &&
                  widget.notification.gameTwo.id != -1
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: SwapThemeDataService.getPrimary(),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        widget.onSwapComplete(widget.notification.swapId);
                      },
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  Widget _gameSelector(Games game) {
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
          child: Container(
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
          ),
        ),
      ],
    );
  }
}
