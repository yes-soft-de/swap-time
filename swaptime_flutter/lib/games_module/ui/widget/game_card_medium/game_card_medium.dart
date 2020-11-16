import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';

class GameCardMedium extends StatefulWidget {
  final GameModel gameModel;
  final Function(bool) onLoved;
  final Function(String) onReport;
  final Function(String) onChatRequested;

  GameCardMedium({
    @required this.gameModel,
    @required this.onChatRequested,
    @required this.onLoved,
    @required this.onReport,
  });

  @override
  State<StatefulWidget> createState() => _GameCardMediumState();
}

class _GameCardMediumState extends State<GameCardMedium> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset.fromDirection(90, 4),
              blurRadius: 8,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.grey,
            ),
          ],
        ),
        child: Stack(children: [
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: widget.gameModel.imageUrl,
              fit: BoxFit.cover,
              height: 240,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          Text(
                            widget.gameModel.gameTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.gameModel.gameOwnerFirstName,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.gameModel.lovable
                      ? IconButton(
                          icon: Icon(
                            widget.gameModel.loved
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            widget.onLoved(widget.gameModel.loved);
                            widget.gameModel.loved = !widget.gameModel.loved;
                            setState(() {});
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
