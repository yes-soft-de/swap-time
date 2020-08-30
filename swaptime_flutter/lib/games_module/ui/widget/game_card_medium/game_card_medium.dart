import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class GameCardMedium extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            Image.network(gameModel.imageUrl),
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
                            gameModel.gameTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            gameModel.gameOwnerFirstName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        gameModel.loved
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        onLoved(!gameModel.loved);
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
