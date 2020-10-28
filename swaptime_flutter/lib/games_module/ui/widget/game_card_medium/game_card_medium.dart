import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

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
        height: 225,
        width: 160,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: widget.gameModel.imageUrl,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: SwapThemeDataService.getAccent(),
                ),
                onPressed: () {
                  // TODO: Show More Dropdown
                },
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
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          Text(
                            widget.gameModel.gameTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            widget.gameModel.gameOwnerFirstName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
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
      ),
    );
  }
}
