import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';

class GameCardSmall extends StatelessWidget {
  final Function(bool) onLoved;
  final Function(String) onReport;
  final Function(String) onChatRequested;
  final GameModel gameModel;

  GameCardSmall({
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
        height: 112,
        width: 112,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(90, 4),
            blurRadius: 8,
            color: Colors.grey,
          )
        ]),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                gameModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: IconButton(
                        icon: gameModel.loved
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          onLoved(!gameModel.loved);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
