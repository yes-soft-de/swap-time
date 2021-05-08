import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_game_card/exchange_game_card.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class ExchangeSetterWidget extends StatefulWidget {
  final GamesListService gamesListService;
  final String userId;
  final List<int> restrictedList;

  ExchangeSetterWidget(
      {@required this.gamesListService,
      @required this.userId,
      this.restrictedList});

  @override
  State<StatefulWidget> createState() => _ExchangeSetterWidgetState();
}

class _ExchangeSetterWidgetState extends State<ExchangeSetterWidget> {
  Games activeGame;
  List<Games> userGames;

  @override
  void initState() {
    super.initState();
    widget.gamesListService.getUserGames(widget.userId).then((value) {
      userGames = _processGames(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).setExchangeGame,
            style: TextStyle(fontSize: 24),
          ),
          userGames != null
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: getGamesCards(userGames),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(S.of(context).loading),
                ),
          activeGame != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: SwapThemeDataService.getPrimary(),
                      onPressed: () {
                        Navigator.of(context).pop(activeGame);
                      },
                      child: Text(
                        S.of(context).setGame,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 44,
                )
        ],
      ),
    );
  }

  List<Widget> getGamesCards(List<Games> games) {
    List<Widget> gameCards = [];
    print('Restricted List: ${widget.restrictedList.toString()}');

    var visibleGames = games;
    if (widget.restrictedList != null) {
      visibleGames =
          games.where((g) => !widget.restrictedList.contains(g.id)).toList();
    }
    visibleGames.forEach((game) {
      gameCards.add(Container(
        child: activeGame != null
            ? ExchangeGameCard(
                game,
                activeGame.id == game.id,
                (game) {
                  activeGame = game;
                  setState(() {});
                },
              )
            : ExchangeGameCard(
                game,
                false,
                (game) {
                  activeGame = game;
                  setState(() {});
                },
              ),
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
