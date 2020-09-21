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
        Text('Error Loading Items!'),
        OutlineButton(onPressed: () {
          widget._stateManager.getAvailableGames();
        })
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
    state.games.forEach((element) {
      cards.add(GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(GamesRoutes.ROUTE_GAME_DETAILS, arguments: element.id);
        },
        child: FutureBuilder(
          future: widget._stateManager.isLoved(element.id),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot != null) {
              return GameCardSmall(
                gameModel: GameModel(
                  gameTitle: element.name,
                  imageUrl: element.mainImage,
                  gameOwnerFirstName: element.userID,
                  loved: snapshot.data,
                  itemId: element.id,
                ),
                onChatRequested: (itemId) {},
                onLoved: (loved) {
                  if (loved) {
                    widget._stateManager.unLove(element.id);
                  } else {
                    widget._stateManager.love(element.id);
                  }
                },
                onReport: (itemId) {
                  Fluttertoast.showToast(msg: 'Report is Sent!');
                },
              );
            } else {
              return GameCardSmall(
                gameModel: GameModel(
                  gameTitle: element.name,
                  imageUrl: element.mainImage,
                  gameOwnerFirstName: element.userID,
                  loved: false,
                  itemId: element.id,
                ),
                onChatRequested: (itemId) {},
                onLoved: (loved) {
                  if (loved) {
                    widget._stateManager.unLove(element.id);
                  } else {
                    widget._stateManager.love(element.id);
                  }
                },
                onReport: (itemId) {
                  Fluttertoast.showToast(msg: 'Report is Sent!');
                },
              );
            }
          },
        ),
      ));
    });
    return cards;
  }

  List<Widget> getMediumCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    state.games.forEach((element) {
      cards.add(FutureBuilder(
        future: widget._stateManager.isLoved(element.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot != null) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
                    arguments: element.id);
              },
              child: GameCardMedium(
                gameModel: GameModel(
                  gameTitle: element.name,
                  imageUrl: element.mainImage,
                  gameOwnerFirstName: element.userID,
                  loved: snapshot.data,
                  itemId: element.id,
                ),
                onChatRequested: (itemId) {},
                onLoved: (loved) {
                  if (loved) {
                    widget._stateManager.unLove(element.id);
                  } else {
                    widget._stateManager.love(element.id);
                  }
                },
                onReport: (itemId) {
                  Fluttertoast.showToast(msg: 'Report is Sent!');
                },
              ),
            );
          } else {
            return GameCardMedium(
              gameModel: GameModel(
                gameTitle: element.name,
                imageUrl: element.mainImage,
                gameOwnerFirstName: element.userID,
                loved: false,
                itemId: element.id,
              ),
              onChatRequested: (itemId) {},
              onLoved: (loved) {
                if (loved) {
                  widget._stateManager.unLove(element.id);
                } else {
                  widget._stateManager.love(element.id);
                }
              },
              onReport: (itemId) {
                Fluttertoast.showToast(msg: 'Report is Sent!');
              },
            );
          }
        },
      ));
    });
    return cards;
  }

  List<Widget> getLargeCards() {
    GamesListStateLoadSuccess state = currentState;
    List<Widget> cards = [];
    state.games.forEach((element) {
      cards.add(FutureBuilder(
        future: widget._stateManager.isLoved(element.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot != null) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
                    arguments: element.id);
              },
              child: GameCardLarge(
                gameModel: GameModel(
                  gameTitle: element.name,
                  imageUrl: element.mainImage,
                  gameOwnerFirstName: element.userID,
                  loved: snapshot.data,
                  itemId: element.id,
                ),
                onChatRequested: (itemId) {},
                onLoved: (loved) {
                  if (loved) {
                    widget._stateManager.unLove(element.id);
                  } else {
                    widget._stateManager.love(element.id);
                  }
                },
                onReport: (itemId) {
                  Fluttertoast.showToast(msg: 'Report is Sent!');
                },
              ),
            );
          } else {
            return GameCardLarge(
              gameModel: GameModel(
                gameTitle: element.name,
                imageUrl: element.mainImage,
                gameOwnerFirstName: element.userID,
                loved: false,
                itemId: element.id,
              ),
              onChatRequested: (itemId) {},
              onLoved: (loved) {
                if (loved) {
                  widget._stateManager.unLove(element.id);
                } else {
                  widget._stateManager.love(element.id);
                }
              },
              onReport: (itemId) {
                Fluttertoast.showToast(msg: 'Report is Sent!');
              },
            );
          }
        },
      ));
    });
    return cards;
  }
}
