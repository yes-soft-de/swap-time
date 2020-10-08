import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentState {}

class CommentStateLoadSuccess extends CommentState {
  List<CommentModel> commentList;
  CommentStateLoadSuccess(this.commentList);
}
