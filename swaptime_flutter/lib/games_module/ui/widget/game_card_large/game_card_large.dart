import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class GameCardLarge extends StatefulWidget {
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
  State<StatefulWidget> createState() => _GameCardLargeState();
}

class _GameCardLargeState extends State<GameCardLarge> {
  @override
  Widget build(BuildContext context) {
    widget.gameModel.imageUrl ??=
        'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/link_broken.png';
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
      height: 208,
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
      child: Stack(
        children: [
          FittedBox(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: widget.gameModel.imageUrl,
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
                            widget.gameModel.gameTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.gameModel.gameOwnerFirstName,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.gameModel.loved
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: SwapThemeDataService.getPrimary(),
                      ),
                      onPressed: () {
                        widget.onLoved(widget.gameModel.loved);
                        widget.gameModel.loved = !widget.gameModel.loved;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: SwapThemeDataService.getPrimary(),
                      ),
                      onPressed: () {
                        widget.onChatRequested(widget.gameModel.itemId);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.flag,
                        color: SwapThemeDataService.getPrimary(),
                      ),
                      onPressed: () {
                        widget.onReport(widget.gameModel.itemId);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
