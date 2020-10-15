class InteractionResponse {
  String statusCode;
  String msg;
  Data data;

  InteractionResponse({this.statusCode, this.msg, this.data});

  InteractionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String userID;
  String swapItemID;
  int type;

  Data({this.id, this.userID, this.swapItemID, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    swapItemID = json['swapItemID'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    data['type'] = this.type;
    return data;
  }
}
