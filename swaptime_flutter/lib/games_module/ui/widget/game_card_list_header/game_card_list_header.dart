import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class GameCardListHeader extends StatefulWidget {
  final GameCardType selectedCardType;
  final Function(GameCardType) onTypeChanged;
  final Function(SortByType) onSortChanged;

  GameCardListHeader(
      {@required this.selectedCardType,
      @required this.onTypeChanged,
      @required this.onSortChanged});

  @override
  State<StatefulWidget> createState() => _GameCardHeader();
}

class _GameCardHeader extends State<GameCardListHeader> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton(
          hint: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.sort),
              ),
              Text(''),
            ],
          ),
          onChanged: (by) {
            widget.onSortChanged(by);
          },
          items: [
            DropdownMenuItem(
              value: SortByType.SORT_BY_ADDED,
              child: Text(S.of(context).byAdded),
            ),
            DropdownMenuItem(
              value: SortByType.SORT_BY_NAME,
              child: Text(S.of(context).byName),
            ),
            DropdownMenuItem(
              value: SortByType.SORT_BY_COMMENTS,
              child: Text(S.of(context).byComments),
            ),
          ],
        ),
        Text(S.of(context).gamesList),
        Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              color: widget.selectedCardType == GameCardType.GAME_CARD_LARGE
                  ? SwapThemeDataService.getAccent()
                  : SwapThemeDataService.getPrimary(),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (widget.selectedCardType != GameCardType.GAME_CARD_LARGE) {
                    widget.onTypeChanged(GameCardType.GAME_CARD_LARGE);
                  }
                },
              ),
            ),
            Container(
              color: widget.selectedCardType == GameCardType.GAME_CARD_MEDIUM
                  ? SwapThemeDataService.getAccent()
                  : SwapThemeDataService.getPrimary(),
              child: IconButton(
                icon: Icon(
                  Icons.apps,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (widget.selectedCardType !=
                      GameCardType.GAME_CARD_MEDIUM) {
                    widget.onTypeChanged(GameCardType.GAME_CARD_MEDIUM);
                  }
                },
              ),
            ),
            Container(
              color: widget.selectedCardType == GameCardType.GAME_CARD_SMALL
                  ? SwapThemeDataService.getAccent()
                  : SwapThemeDataService.getPrimary(),
              child: IconButton(
                icon: Icon(
                  Icons.grid_on,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (widget.selectedCardType != GameCardType.GAME_CARD_SMALL) {
                    widget.onTypeChanged(GameCardType.GAME_CARD_SMALL);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum GameCardType { GAME_CARD_SMALL, GAME_CARD_MEDIUM, GAME_CARD_LARGE }

enum SortByType { SORT_BY_NAME, SORT_BY_ADDED, SORT_BY_COMMENTS }
