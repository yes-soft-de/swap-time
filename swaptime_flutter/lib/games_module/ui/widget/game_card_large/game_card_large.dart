import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class GameCardLarge extends StatelessWidget {
  final GameModel gameModel;
  final Function(bool) onLoved;
  final Function(String) onReport;
  final Function(String) onChatRequested;

  GameCardLarge({
    @required this.gameModel,
    @required this.onChatRequested,
    @required this.onLoved,
    @required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Container(
        height: 208,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(90, 4),
            blurRadius: 8,
            color: Colors.grey,
          ),
        ], color: SwapThemeData.isDarkMode() ? Colors.white : Colors.white),
        child: Stack(
          children: [
            FittedBox(
              child: Image.network(
                gameModel.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gameModel.gameTitle,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: SwapThemeData.isDarkMode()
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            Text(
                              gameModel.gameOwnerFirstName,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: SwapThemeData.isDarkMode()
                                      ? Colors.white
                                      : Colors.black),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          gameModel.loved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: SwapThemeData.getPrimary(),
                        ),
                        onPressed: () {
                          onLoved(!gameModel.loved);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: SwapThemeData.getPrimary(),
                        ),
                        onPressed: () {
                          onChatRequested(gameModel.itemId);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.flag,
                          color: SwapThemeData.getPrimary(),
                        ),
                        onPressed: () {
                          onReport(gameModel.itemId);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
