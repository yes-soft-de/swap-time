import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module//ui/widget/game_card_large/game_card_large.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list_header/game_card_list_header.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_medium/game_card_medium.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_small/game_card_small.dart';

class GameCardList extends StatefulWidget {
  GameCardList();

  @override
  State<StatefulWidget> createState() => _GameCardListState();
}

class _GameCardListState extends State<GameCardList> {
  GameCardType currentType = GameCardType.GAME_CARD_MEDIUM;
  GameModel game = GameModel(
    itemId: '1',
    imageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
    gameTitle: 'GTA V',
    loved: true,
    gameOwnerFirstName: 'Mohammad',
  );

  @override
  Widget build(BuildContext context) {
    Widget gameCards;

    switch (currentType) {
      case GameCardType.GAME_CARD_SMALL:
        gameCards = GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            GameCardSmall(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardSmall(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardSmall(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardSmall(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
          ],
        );
        break;
      case GameCardType.GAME_CARD_MEDIUM:
        gameCards = GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            GameCardMedium(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardMedium(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardMedium(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardMedium(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
          ],
        );
        break;
      case GameCardType.GAME_CARD_LARGE:
        gameCards = GridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            GameCardLarge(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardLarge(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardLarge(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
            GameCardLarge(
              gameModel: game,
              onChatRequested: (itemId) {},
              onLoved: (loved) {},
              onReport: (itemId) {},
            ),
          ],
        );
        break;
      default:
    }

    return Flex(
      direction: Axis.vertical,
      children: [
        GameCardListHeader(
          selectedCardType: currentType,
          onTypeChanged: (newType) {
            currentType = newType;
            setState(() {});
          },
        ),
        Container(
          height: 16,
        ),
        gameCards
      ],
    );
  }
}
