import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class ExchangeGameCard extends StatelessWidget {
  final Games game;
  final bool active;
  final Function(Games) onGameSelected;

  ExchangeGameCard(
    this.game,
    this.active,
    this.onGameSelected,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onGameSelected(game);
      },
      child: Flex(
        direction: Axis.vertical,
        children: [
          !active
              ? Container(
                  height: 112,
                  width: 112,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.png',
                          image: game.mainImage.substring(29),
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  height: 112,
                  width: 112,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(game.mainImage.substring(29)),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Color(0x44000000),
                        ),
                      ),
                      Positioned.fill(
                          child: Container(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ))
                    ],
                  ),
                ),
          Text(game.name),
        ],
      ),
    );
  }
}
