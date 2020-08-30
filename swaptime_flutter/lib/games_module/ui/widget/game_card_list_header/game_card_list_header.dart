import 'package:flutter/material.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class GameCardListHeader extends StatelessWidget {
  final GameCardType selectedCardType;
  final Function(GameCardType) onTypeChanged;

  GameCardListHeader({
    @required this.selectedCardType,
    @required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Games List'),
        Container(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                color: selectedCardType == GameCardType.GAME_CARD_LARGE
                    ? SwapThemeData.getAccent()
                    : SwapThemeData.getPrimary(),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (selectedCardType != GameCardType.GAME_CARD_LARGE) {
                      onTypeChanged(GameCardType.GAME_CARD_LARGE);
                    }
                  },
                ),
              ),
              Container(
                color: selectedCardType == GameCardType.GAME_CARD_MEDIUM
                    ? SwapThemeData.getAccent()
                    : SwapThemeData.getPrimary(),
                child: IconButton(
                  icon: Icon(
                    Icons.apps,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (selectedCardType != GameCardType.GAME_CARD_MEDIUM) {
                      onTypeChanged(GameCardType.GAME_CARD_MEDIUM);
                    }
                  },
                ),
              ),
              Container(
                color: selectedCardType == GameCardType.GAME_CARD_SMALL
                    ? SwapThemeData.getAccent()
                    : SwapThemeData.getPrimary(),
                child: IconButton(
                  icon: Icon(
                    Icons.grid_on,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (selectedCardType != GameCardType.GAME_CARD_SMALL) {
                      onTypeChanged(GameCardType.GAME_CARD_SMALL);
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

enum GameCardType { GAME_CARD_SMALL, GAME_CARD_MEDIUM, GAME_CARD_LARGE }
