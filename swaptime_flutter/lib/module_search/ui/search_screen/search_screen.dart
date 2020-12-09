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
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class SearchScreen extends StatefulWidget {
  final GamesListStateManager _stateManager;
  final AuthService _authService;

  SearchScreen(
    this._stateManager,
    this._authService,
  );

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GameCardType currentType = GameCardType.GAME_CARD_MEDIUM;
  GamesListState currentState = GamesListStateInit();
  List<Games> gamesList = [];
  List<Games> visibleGames = [];

  String activeSearchQuery;

  SortByType activeSort;

  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (currentState is GamesListStateLoadSuccess) {
        GamesListStateLoadSuccess state = currentState;
        gamesList = _processList(state.games);
        visibleGames = gamesList;
      }
      if (mounted) setState(() {});
    });

    widget._authService.isLoggedIn.then((value) {
      loggedIn = value;
    });
    widget._stateManager.getAvailableGames();
  }

  @override
  Widget build(BuildContext context) {
    if (activeSearchQuery == null) {
      if (ModalRoute.of(context).settings.arguments is String) {
        activeSearchQuery = ModalRoute.of(context).settings.arguments;
      }
    }
    return calibrateScreen();
  }

  Widget calibrateScreen() {
    switch (currentState.runtimeType) {
      case GamesListStateLoadSuccess:
        return getSuccessUI();
        break;
      case GamesListStateLoadError:
        return Scaffold(body: getErrorUI());
        break;
      case GamesListStateLoading:
        return Scaffold(
          body: getLoadingUI(),
        );
        break;
      default:
        return Scaffold(body: getLoadingUI());
    }
  }

  Widget getLoadingUI() {
    if (gamesList != null) {
      if (gamesList.isNotEmpty) {
        return getSuccessUI();
      }
    }
    return Scaffold(
      appBar: SwaptimeAppBar.getSearchAppBar(
        context: context,
        activeQuery: activeSearchQuery,
        watcherEnabled: true,
        onSearchRequested: (searchQuery) {
          if (searchQuery == null) {
            Navigator.of(context).pop();
          }
          if (searchQuery != null && searchQuery != activeSearchQuery) {
            activeSearchQuery = searchQuery;
            _processList(gamesList);
            setState(() {});
          }
        },
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget getErrorUI() {
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

  Widget getSuccessUI() {
    Widget gamesGrid = GridView.count(
      crossAxisCount: 1,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: getLargeCards(),
    );

    return Scaffold(
      appBar: SwaptimeAppBar.getSearchAppBar(
        context: context,
        watcherEnabled: true,
        activeQuery: activeSearchQuery,
        onSearchRequested: (searchQuery) {
          if (searchQuery == null) {
            Navigator.of(context).pop();
            return;
          }
          if (searchQuery.isNotEmpty) {
            if (searchQuery != activeSearchQuery) {
              activeSearchQuery = searchQuery;
              _processList(gamesList);
              setState(() {});
            }
          }
        },
      ),
      body: ListView(
        children: [
          gamesGrid,
        ],
      ),
    );
  }

  void _calcVisibleBySearchQuery() {
    if (activeSearchQuery != null) {
      List<Games> activeGames = [];
      gamesList.forEach((element) {
        if (element.name
            .toLowerCase()
            .contains(activeSearchQuery.toLowerCase())) {
          activeGames.add(element);
          return;
        }
        if (element.description
            .toLowerCase()
            .contains(activeSearchQuery.toLowerCase())) {
          activeGames.add(element);
          return;
        }
        if (element.tag.contains(activeSearchQuery.toLowerCase())) {
          activeGames.add(element);
          return;
        }
      });
      visibleGames = activeGames;
    }
  }

  List<Widget> getLargeCards() {
    List<Widget> cards = [];
    _calcVisibleBySearchQuery();
    for (int i = 0; i < visibleGames.length; i++) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: visibleGames[i].id);
        },
        child: GameCardLarge(
          gameModel: GameModel(
            gameTitle: visibleGames[i].name,
            imageUrl: visibleGames[i].mainImage,
            gameOwnerFirstName: visibleGames[i].name,
            lovable: loggedIn,
            loved: visibleGames[i].interaction.checkLoved && loggedIn,
            itemId: visibleGames[i].id.toString(),
          ),
          comments: int.tryParse(visibleGames[i].commentNumber),
          onChatRequested: (itemId) {
            Navigator.of(context)
                .pushNamed(GamesRoutes.ROUTE_GAME_DETAILS, arguments: itemId);
          },
          onLoved: (loved) {
            if (loved) {
              widget._stateManager.unLove(visibleGames[i].id.toString());
            } else {
              widget._stateManager
                  .love(visibleGames[i].id.toString(), null)
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
    print('Processing data, sorting ' + activeSort.toString());
    Map<int, dynamic> games = {};
    gamesList.forEach((element) {
      games[element.id] = element;
    });
    return _sortList(List.from(games.values));
  }

  List<Games> _sortList(List<Games> games) {
    if (activeSort == SortByType.SORT_BY_NAME) {
      games.sort((a, b) => a.name.compareTo(b.name));
      return games;
    } else if (activeSort == SortByType.SORT_BY_COMMENTS) {
      games.sort((a, b) => a.commentNumber.compareTo(b.commentNumber));
      return games;
    } else {
      return games;
    }
  }
}
