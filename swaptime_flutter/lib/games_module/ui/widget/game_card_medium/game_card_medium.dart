import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

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
    widget.gameModel.imageUrl ??=
        'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/link_broken.png';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 225,
        width: 160,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(90, 4),
            blurRadius: 8,
            color: Colors.grey,
          ),
        ], color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Image.network(widget.gameModel.imageUrl),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: SwapThemeData.getAccent(),
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
                color: Colors.white,
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
                    IconButton(
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
                    ),
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
