import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_notifications/model/notifcation_item/notification_item.dart';

class NotificationComplete extends StatefulWidget {
  final NotificationModel notification;
  final String myId;

  NotificationComplete({
    this.notification,
    this.myId,
  });

  @override
  _NotificationCompleteState createState() => _NotificationCompleteState();
}

class _NotificationCompleteState extends State<NotificationComplete> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
      child: Card(
        color: Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black,
        child: Container(
          height: 168,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                  height: 120,
                  child: Stack(
                    children: [
                      _getGamesRow(),
                      _getConfirmationOverlay(),
                    ],
                  )),
              _getCardFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getConfirmationOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black38,
        child: Center(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).swapCompleted,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
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
              child: FadeInImage.assetNetwork(
                placeholder: '/assets/images/logo.jpg',
                image: widget.notification.gameOne.mainImage,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FadeInImage.assetNetwork(
                placeholder: '/assets/images/logo.jpg',
                height: 120,
                image: widget.notification.gameTwo.mainImage,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
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
