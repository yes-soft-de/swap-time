import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';

class ExchangeGameCard extends StatefulWidget {
  final Games game;
  final Function(String) onGameSelected;

  ExchangeGameCard(
    this.game,
    this.onGameSelected,
  );

  @override
  State<StatefulWidget> createState() => _ExchangeGameCardState();
}

class _ExchangeGameCardState extends State<ExchangeGameCard> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        active = !active;
        if (active) {
          widget.onGameSelected(widget.game.id);
        }
      },
      child: Flex(
        direction: Axis.vertical,
        children: [
          active
              ? Container(
                  height: 112,
                  width: 112,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(widget.game.mainImage),
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
                        child: Image.network(widget.game.mainImage),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black26,
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
          Text(widget.game.name),
        ],
      ),
    );
  }
}
