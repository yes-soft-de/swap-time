import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
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
      initialData: <Games>[],
      future: widget.gamesListService.getMyGames(),
      builder: (context, snapshot) {
        return Container(
          height: 320,
          width: MediaQuery.of(context).size.width - 32,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).restrictAccessTo,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.hasData
                      ? _getGamesCards(snapshot.data)
                      : Container(
                          height: 120,
                        ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (restrictedGames.length >= snapshot.data.length) {
                      return;
                    }
                    Navigator.of(context).pop(restrictedGames.toList());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: restrictedGames.length < snapshot.data.length
                        ? Text(
                            S.of(context).confirmRequest,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )
                        : Text(
                            S.of(context).atLeastOneProductIsRequired,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
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
              setState(() {});
            } else {
              restrictedGames.add(id);
              setState(() {});
            }
          },
        ),
      );
    });

    return cards;
  }
}
