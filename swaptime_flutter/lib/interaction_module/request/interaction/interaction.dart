class InteractionRequest {
  String userID;
  String swapItemID;
  int type;
  String id;

  InteractionRequest({this.userID, this.swapItemID, this.type, this.id});

  InteractionRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    swapItemID = json['swapItemID'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}
