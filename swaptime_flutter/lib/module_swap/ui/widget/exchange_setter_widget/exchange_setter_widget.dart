import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_game_card/exchange_game_card.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class ExchangeSetterWidget extends StatefulWidget {
  final GamesListService gamesListService;
  final String userId;
  final String myId;

  ExchangeSetterWidget({
    @required this.gamesListService,
    @required this.userId,
    @required this.myId,
  });

  @override
  State<StatefulWidget> createState() => _ExchangeSetterWidgetState();
}

class _ExchangeSetterWidgetState extends State<ExchangeSetterWidget> {
  Games activeGame;
  List<Games> userGames;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      widget.gamesListService.getUserGames(widget.userId).then((value) {
        userGames = _processGames(value);
        setState(() {});
      });
    } else {
      widget.gamesListService.getUserGames(widget.myId).then((value) {
        userGames = _processGames(value);
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('New Build');
    return Container(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).setExchangeGame,
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: userGames != null
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: getGamesCards(userGames),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(S.of(context).loading),
                    ),
            ),
            activeGame != null
                ? Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: SwapThemeDataService.getPrimary(),
                          onPressed: () {
                            print('Setting Active Game ID: ' +
                                activeGame.id.toString() +
                                ' For User: ' +
                                activeGame.userID);
                            Navigator.of(context).pop(activeGame);
                          },
                          child: Text(
                            S.of(context).setGame,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  List<Widget> getGamesCards(List<Games> games) {
    List<Widget> gameCards = [];
    games.forEach((game) {
      gameCards.add(activeGame != null
          ? ExchangeGameCard(
              game,
              activeGame.id == game.id,
              (game) {
                activeGame = game;
                print('New Game ${activeGame.id}');
                setState(() {});
              },
            )
          : ExchangeGameCard(
              game,
              false,
              (game) {
                activeGame = game;
                print('New Game ${activeGame.id}');
                setState(() {});
              },
            ));
    });
    return gameCards;
  }

  List<Games> _processGames(List<Games> games) {
    Map<int, Games> map = {};
    games.forEach((element) {
      map[element.id] = element;
    });
    return List.of(map.values);
  }
}
