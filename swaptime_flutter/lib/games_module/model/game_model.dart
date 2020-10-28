import 'package:flutter/cupertino.dart';

class GameModel {
  String gameTitle;
  String imageUrl;
  String gameOwnerFirstName;
  String itemId;
  bool loved;
  bool lovable;

  GameModel(
      {@required this.gameTitle,
      @required this.imageUrl,
      @required this.gameOwnerFirstName,
      @required this.itemId,
      this.lovable,
      @required this.loved});
}
