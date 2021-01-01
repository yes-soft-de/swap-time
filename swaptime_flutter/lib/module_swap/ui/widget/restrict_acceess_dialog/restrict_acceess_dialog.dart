import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/restrict_access_card/restrict_access_card.dart';

@provide
class RestrictAccessDialog extends StatefulWidget {
  final GamesListService gamesListService;
  RestrictAccessDialog(this.gamesListService);

  @override
  State<StatefulWidget> createState() => _RestrictAccessDialogState();
}

class _RestrictAccessDialogState extends State<RestrictAccessDialog> {
  var restrictedGames = <int>{};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: widget.gamesListService.getMyGames(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Restrict Access To: '),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _getGamesCards(snapshot.data),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(restrictedGames.toList());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Confirm Request'),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .5,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getGamesCards(List<Games> gamesList) {
    var cards = <Widget>[];
    gamesList.forEach((element) {
      cards.add(
        RestrictAccessCard(
          image: element.mainImage,
          restricted: restrictedGames.contains(element.id),
          productId: element.id,
          onProductPressed: (id) {
            if (restrictedGames.contains(id)) {
              restrictedGames.remove(id);
            } else {
              restrictedGames.add(id);
            }
          },
        ),
      );
    });

    return cards;
  }
}
