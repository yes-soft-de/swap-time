import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

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
        Text(S.of(context).gamesList),
        Container(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                color: selectedCardType == GameCardType.GAME_CARD_LARGE
                    ? SwapThemeDataService.getAccent()
                    : SwapThemeDataService.getPrimary(),
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
                    ? SwapThemeDataService.getAccent()
                    : SwapThemeDataService.getPrimary(),
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
                    ? SwapThemeDataService.getAccent()
                    : SwapThemeDataService.getPrimary(),
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
