class CreateCommentResponse {
  String statusCode;
  String msg;
  Data data;

  CreateCommentResponse({this.statusCode, this.msg, this.data});

  CreateCommentResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String comment;
  String userID;
  int swapItemID;

  Data({this.comment, this.userID, this.swapItemID});

  Data.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    userID = json['userID'];
    swapItemID = json['swapItemID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    return data;
  }
}
