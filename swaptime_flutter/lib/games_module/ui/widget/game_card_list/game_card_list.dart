import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/games_routes.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/games_module/state_manager/games_list_state_manager/games_list_state_manager.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_large/game_card_large.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list_header/game_card_list_header.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_medium/game_card_medium.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_small/game_card_small.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';

@provide
class GameCardList extends StatefulWidget {
  final GamesListStateManager _stateManager;

  GameCardList(this._stateManager);

  @override
  State<StatefulWidget> createState() => _GameCardListState();
}

class _GameCardListState extends State<GameCardList> {
  GameCardType currentType = GameCardType.GAME_CARD_MEDIUM;
  GamesListState currentState = GamesListStateInit();

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
    widget._stateManager.getAvailableGames();
  }

  @override
  Widget build(BuildContext context) {
    return calibrateScreen();
  }

  Widget calibrateScreen() {
    switch (currentState.runtimeType) {
      case GamesListStateLoadSuccess:
        return setSuccessUI();
        break;
      case GamesListStateLoadError:
        return setErrorUI();
        break;
      case GamesListStateLoading:
        return setLoadingUI();
        break;
      default:
        return Container();
    }
  }

  Widget setLoadingUI() {
    return Flex(
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
  }

  Widget setErrorUI() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).errorLoadingItems),
        OutlineButton(
          onPressed: () {
            widget._stateManager.getAvailableGames();
          },
          child: Text(S.of(context).retry),
        )
      ],
    );
  }

  Widget setSuccessUI() {
    Widget gamesGrid;
    switch (currentType) {
      case GameCardType.GAME_CARD_SMALL:
        gamesGrid = FutureBuilder(
          future: getSmallCards(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: snapshot.data);
          },
        );
        break;
      case GameCardType.GAME_CARD_MEDIUM:
        gamesGrid = FutureBuilder(
          future: getMediumCards(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: snapshot.data,
            );
          },
        );
        break;
      case GameCardType.GAME_CARD_LARGE:
        gamesGrid = FutureBuilder(
          future: getLargeCards(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.count(
              crossAxisCount: 1,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: snapshot.data,
            );
          },
        );
        break;
      default:
        return Container();
    }

    return Flex(
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
  }

  Future<List<Widget>> getSmallCards() async {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];

    for (int i = 0; i < state.games.length; i++) {
      bool loved = await widget._stateManager.isLoved(state.games[i].id);
      loved ??= false;
      String username =
          await widget._stateManager.getUserName(state.games[i].userID);
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: state.games[i].id);
        },
        child: GameCardSmall(
          gameModel: GameModel(
            gameTitle: state.games[i].name,
            imageUrl: state.games[i].mainImage,
            gameOwnerFirstName: username,
            loved: loved,
            itemId: state.games[i].id,
          ),
          onChatRequested: (itemId) {},
          onLoved: (loved) {
            if (loved) {
              widget._stateManager.unLove(state.games[i].id);
            } else {
              widget._stateManager.love(state.games[i].id).then((value) {
                if (value == null) {
                  Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                }
              });
            }
          },
          onReport: (itemId) {
            Fluttertoast.showToast(msg: 'Report is Sent!');
          },
        ),
      ));
    }

    return cards;
  }

  Future<List<Widget>> getMediumCards() async {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    for (int i = 0; i < state.games.length; i++) {
      bool loved = await widget._stateManager.isLoved(state.games[i].id);
      loved ??= false;
      String username =
          await widget._stateManager.getUserName(state.games[i].userID);
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: state.games[i].id);
        },
        child: GameCardMedium(
          gameModel: GameModel(
            gameTitle: state.games[i].name,
            imageUrl: state.games[i].mainImage,
            gameOwnerFirstName: username,
            loved: loved,
            itemId: state.games[i].id,
          ),
          onChatRequested: (itemId) {},
          onLoved: (loved) {
            if (loved) {
              widget._stateManager.unLove(state.games[i].id);
            } else {
              widget._stateManager.love(state.games[i].id).then((value) {
                if (value == null) {
                  Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                }
              });
            }
          },
          onReport: (itemId) {
            Fluttertoast.showToast(msg: 'Report is Sent!');
          },
        ),
      ));
    }
    return cards;
  }

  Future<List<Widget>> getLargeCards() async {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];

    for (int i = 0; i < state.games.length; i++) {
      bool loved = await widget._stateManager.isLoved(state.games[i].id);
      loved ??= false;
      String username =
          await widget._stateManager.getUserName(state.games[i].userID);
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: state.games[i].id);
        },
        child: GameCardLarge(
          gameModel: GameModel(
            gameTitle: state.games[i].name,
            imageUrl: state.games[i].mainImage,
            gameOwnerFirstName: username,
            loved: loved,
            itemId: state.games[i].id,
          ),
          onChatRequested: (itemId) {
            Navigator.of(context)
                .pushNamed(GamesRoutes.ROUTE_GAME_DETAILS, arguments: itemId);
          },
          onLoved: (loved) {
            if (loved) {
              widget._stateManager.unLove(state.games[i].id);
            } else {
              widget._stateManager.love(state.games[i].id).then((value) {
                if (value == null) {
                  Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                }
              });
            }
          },
          onReport: (itemId) {
            Fluttertoast.showToast(msg: 'Report is Sent!');
          },
        ),
      ));
    }

    return cards;
  }
}
