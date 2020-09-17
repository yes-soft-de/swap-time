import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/games_module/state_manager/games_list_state_manager/games_list_state_manager.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_large/game_card_large.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list_header/game_card_list_header.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_medium/game_card_medium.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_small/game_card_small.dart';

@provide
class GameCardList extends StatefulWidget {
  final GamesListStateManager _stateManager;

  GameCardList(this._stateManager);

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

  GamesListState currentState = GamesListStateInit();
  Flex currentUI;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      calibrateScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUI == null) {
      setLoadingUI();
    }
    return currentUI;
  }

  void calibrateScreen() {
    switch (currentState.runtimeType) {
      case GamesListStateLoadSuccess:
        setSuccessUI();
        break;
      case GamesListStateLoadError:
        setErrorUI();
        break;
      case GamesListStateLoading:
        setLoadingUI();
        break;
    }
  }

  void setLoadingUI() {
    currentUI = Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            CircularProgressIndicator(),
          ],
        )
      ],
    );
    if (mounted) setState(() {});
  }

  void setErrorUI() {
    currentUI = Flex(
      direction: Axis.vertical,
      children: [
        Text('Error Loading Items!'),
        OutlineButton(onPressed: () {
          widget._stateManager.getAvailableGames();
        })
      ],
    );
    if (mounted) setState(() {});
  }

  void setSuccessUI() {
    Widget gamesGrid;
    switch (currentType) {
      case GameCardType.GAME_CARD_SMALL:
        gamesGrid = GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: getSmallCards());
        break;
      case GameCardType.GAME_CARD_MEDIUM:
        gamesGrid = GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: getMediumCards(),
        );
        break;
      case GameCardType.GAME_CARD_LARGE:
        gamesGrid = GridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: getLargeCards(),
        );
        break;
      default:
    }

    currentUI = Flex(
      direction: Axis.vertical,
      children: [
        GameCardListHeader(
          selectedCardType: currentType,
          onTypeChanged: (newType) {
            currentType = newType;
            if (mounted) setState(() {});
          },
        ),
        Container(
          height: 16,
        ),
        gamesGrid
      ],
    );

    if (mounted) setState(() {});
  }

  List<Widget> getSmallCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    state.games.forEach((element) {
      cards.add(GameCardSmall(
        gameModel: GameModel(
          gameTitle: element.name,
          imageUrl: element.mainImage,
          gameOwnerFirstName: element.userID,
          loved: element.commentNumber > 0,
          itemId: element.id,
        ),
        onChatRequested: (itemId) {},
        onLoved: (loved) {},
        onReport: (itemId) {},
      ));
    });
    return cards;
  }

  List<Widget> getMediumCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    state.games.forEach((element) {
      cards.add(GameCardMedium(
        gameModel: GameModel(
          gameTitle: element.name,
          imageUrl: element.mainImage,
          gameOwnerFirstName: element.userID,
          loved: element.commentNumber > 0,
          itemId: element.id,
        ),
        onChatRequested: (itemId) {},
        onLoved: (loved) {},
        onReport: (itemId) {},
      ));
    });
    return cards;
  }

  List<Widget> getLargeCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    state.games.forEach((element) {
      cards.add(GameCardLarge(
        gameModel: GameModel(
          gameTitle: element.name,
          imageUrl: element.mainImage,
          gameOwnerFirstName: element.userID,
          loved: element.commentNumber > 0,
          itemId: element.id,
        ),
        onChatRequested: (itemId) {},
        onLoved: (loved) {},
        onReport: (itemId) {},
      ));
    });
    return cards;
  }
}
