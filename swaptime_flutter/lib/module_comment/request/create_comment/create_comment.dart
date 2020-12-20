class CreateCommentRequest {
  String comment;
  String date;
  String userID;
  int swapItemID;

  CreateCommentRequest({this.comment, this.date, this.userID, this.swapItemID});

  CreateCommentRequest.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    date = json['date'];
    userID = json['userID'];
    swapItemID = json['swapItemID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['userID'] = this.userID;
    data['swapItemID'] = this.swapItemID;
    return data;
  }
}
