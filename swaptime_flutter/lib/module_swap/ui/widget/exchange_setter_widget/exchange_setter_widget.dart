import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/exchange_game_card/exchange_game_card.dart';

class ExchangeSetterWidget extends StatefulWidget {
  final GamesListService gamesListService;
  final String userId;
  final Function(Games game) onGameSelected;

  ExchangeSetterWidget({
    @required this.gamesListService,
    @required this.userId,
    @required this.onGameSelected,
  });

  @override
  State<StatefulWidget> createState() => _ExchangeSetterWidgetState();
}

class _ExchangeSetterWidgetState extends State<ExchangeSetterWidget> {
  Games activeGame;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).setExchangeGame),
        Expanded(
          child: FutureBuilder(
            future: widget.gamesListService.getUserGames(widget.userId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Games>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: getGamesCards(snapshot.data),
                );
              }
              return Container(
                alignment: Alignment.center,
                child: Text(S.of(context).loading),
              );
            },
          ),
        ),
        activeGame != null
            ? RaisedButton(
                onPressed: () {
                  widget.onGameSelected(activeGame);
                },
                child: Text(S.of(context).setGame),
              )
            : Container()
      ],
    );
  }

  List<Widget> getGamesCards(List<Games> games) {
    List<Widget> gameCards = [];
    games.forEach((game) {
      gameCards.add(ExchangeGameCard(game, (gameId) async {
        activeGame = game;
      }));
    });
    return gameCards;
  }
}
