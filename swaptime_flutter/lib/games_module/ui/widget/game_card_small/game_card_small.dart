import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';

class GameCardSmall extends StatefulWidget {
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
  State<StatefulWidget> createState() => _GameCardSmallState();
}

class _GameCardSmallState extends State<GameCardSmall> {
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
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.grey,
          )
        ]),
        child: Stack(
          children: [
            Positioned.fill(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/logo.jpg',
                image: widget.gameModel.imageUrl,
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: widget.gameModel.lovable
                          ? IconButton(
                              icon: widget.gameModel.loved
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                              onPressed: () {
                                widget.onLoved(widget.gameModel.loved);
                                widget.gameModel.loved =
                                    !widget.gameModel.loved;
                                setState(() {});
                              },
                            )
                          : Container(),
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
