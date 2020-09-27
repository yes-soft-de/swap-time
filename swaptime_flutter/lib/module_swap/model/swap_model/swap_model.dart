class SwapModel {
  String id;
  String swapperId;
  String roomID;
  String swapperGame;
  String ownerGame;
  String ownerId;

  SwapModel(
      {this.id,
      this.swapperId,
      this.roomID,
      this.swapperGame,
      this.ownerGame,
      this.ownerId});

  SwapModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    swapperId = json['swapperId'];
    roomID = json['roomID'];
    swapperGame = json['swapperGame'];
    ownerGame = json['ownerGame'];
    ownerId = json['ownerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['swapperId'] = this.swapperId;
    data['roomID'] = this.roomID;
    data['swapperGame'] = this.swapperGame;
    data['ownerGame'] = this.ownerGame;
    data['ownerId'] = this.ownerId;
    return data;
  }
}
