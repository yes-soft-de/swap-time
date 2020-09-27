class CommentModel {
  String comment;
  String userId;

  CommentModel({this.comment, this.userId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['userId'] = this.userId;
    return data;
  }
}
