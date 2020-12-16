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
      child: !active
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 136,
                width: 136,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.png',
                        image: game.mainImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black38,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            game.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 136,
                width: 136,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        game.mainImage ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          game.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
            ),
    );
  }
}
