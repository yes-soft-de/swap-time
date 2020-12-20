class InteractionRequest {
  String userID;
  String swapItemID;
  int type;
  String date = DateTime.now().toIso8601String();
  String id;

  InteractionRequest(
      {this.userID, this.swapItemID, this.type, this.id, this.date});

  InteractionRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    swapItemID = json['swapItemID'];
    type = json['type'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    data['type'] = this.type;
    data['id'] = this.id;
    data['date'] = this.date;
    return data;
  }
}
