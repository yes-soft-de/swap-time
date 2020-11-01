import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/games_routes.dart';
import 'package:swaptime_flutter/games_module/model/game_model.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/state_manager/games_list_state_manager/games_list_state_manager.dart';
import 'package:swaptime_flutter/games_module/states/games_list_state/game_list_states.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_large/game_card_large.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list_header/game_card_list_header.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_medium/game_card_medium.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_small/game_card_small.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';

@provide
class MyGameCardList extends StatefulWidget {
  final GamesListStateManager _stateManager;
  final AuthService _authService;

  MyGameCardList(this._stateManager, this._authService);

  @override
  State<StatefulWidget> createState() => _MyGameCardListState();
}

class _MyGameCardListState extends State<MyGameCardList> {
  GameCardType currentType = GameCardType.GAME_CARD_MEDIUM;
  GamesListState currentState = GamesListStateInit();

  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });

    widget._authService.isLoggedIn.then((value) {
      loggedIn = value;
    });
    widget._authService.userID.then((userId) {
      widget._stateManager.getUserGames(userId);
    });
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
        gamesGrid = GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: getSmallCards(),
        );
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

  List<Widget> getSmallCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];

    for (int i = 0; i < _processList(state.games).length; i++) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: _processList(state.games)[i].id);
        },
        child: GameCardSmall(
          gameModel: GameModel(
            gameTitle: _processList(state.games)[i].name,
            imageUrl: _processList(state.games)[i].mainImage.substring(29),
            gameOwnerFirstName: _processList(state.games)[i].name,
            lovable: loggedIn,
            loved:
                _processList(state.games)[i].interaction.checkLoved && loggedIn,
            itemId: _processList(state.games)[i].id.toString(),
          ),
          onChatRequested: (itemId) {},
          onLoved: (loved) {
            if (loved) {
              widget._stateManager
                  .unLove(_processList(state.games)[i].id.toString());
            } else {
              widget._stateManager
                  .love(_processList(state.games)[i].id.toString(), null)
                  .then((value) {
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

  List<Widget> getMediumCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    for (int i = 0; i < _processList(state.games).length; i++) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: _processList(state.games)[i].id);
        },
        child: GameCardMedium(
          gameModel: GameModel(
            gameTitle: _processList(state.games)[i].name,
            imageUrl: _processList(state.games)[i].mainImage.substring(29),
            lovable: loggedIn,
            gameOwnerFirstName: _processList(state.games)[i].name,
            loved:
                _processList(state.games)[i].interaction.checkLoved && loggedIn,
            itemId: _processList(state.games)[i].id.toString(),
          ),
          onChatRequested: (itemId) {},
          onLoved: (loved) {
            if (loved) {
              widget._stateManager
                  .unLove(_processList(state.games)[i].id.toString());
            } else {
              widget._stateManager
                  .love(_processList(state.games)[i].id.toString(), null)
                  .then((value) {
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

  List<Widget> getLargeCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];

    for (int i = 0; i < _processList(state.games).length; i++) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: _processList(state.games)[i].id);
        },
        child: GameCardLarge(
          gameModel: GameModel(
            gameTitle: _processList(state.games)[i].name,
            imageUrl: _processList(state.games)[i].mainImage.substring(29),
            gameOwnerFirstName: _processList(state.games)[i].name,
            lovable: loggedIn,
            loved:
                _processList(state.games)[i].interaction.checkLoved && loggedIn,
            itemId: _processList(state.games)[i].id.toString(),
          ),
          onChatRequested: (itemId) {
            Navigator.of(context)
                .pushNamed(GamesRoutes.ROUTE_GAME_DETAILS, arguments: itemId);
          },
          onLoved: (loved) {
            if (loved) {
              widget._stateManager
                  .unLove(_processList(state.games)[i].id.toString());
            } else {
              widget._stateManager
                  .love(_processList(state.games)[i].id.toString(), null)
                  .then((value) {
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

  List<Games> _processList(List<Games> gamesList) {
    Map<int, dynamic> games = {};
    gamesList.forEach((element) {
      games[element.id] = element;
    });
    return List.from(games.values);
  }
}
