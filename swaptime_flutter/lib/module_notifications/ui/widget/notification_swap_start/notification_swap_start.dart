import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class NotificationSwapStart extends StatefulWidget {
  final NotificationModel notification;
  final String myId;
  final Function(Games) onChangeRequest;

  NotificationSwapStart(
      {@required this.notification,
      @required this.onChangeRequest,
      @required this.myId});

  @override
  State<StatefulWidget> createState() => _NotificationSwapStartState();
}

class _NotificationSwapStartState extends State<NotificationSwapStart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: Container(
          height: 168,
          child: Flex(
            direction: Axis.vertical,
            children: [
              _getGamesRow(),
              _getCardFooter(),
            ],
          ),
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
              child: _gameSelector(
                widget.notification.gameOne,
                widget.notification.gameTwo.id != -1,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: _gameSelector(
                widget.notification.gameTwo,
                widget.notification.gameOne.id != -1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _gameSelector(Games game, bool overlayEnabled) {
    return Container(
      height: 120,
      child: Stack(
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
      ),
    );
  }

  Widget _getCardFooter() {
    return Container(
      height: 48,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${widget.notification.userImage}'),
                ),
              ),
            ),
          ),
          Text(widget.notification.gameTwo.userID == widget.myId
              ? widget.notification.gameOne.userName
              : widget.notification.gameTwo.userName)
        ],
      ),
    );
  }
}
