import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_comment/repository/comment/comment_repository.dart';
import 'package:swaptime_flutter/module_comment/request/create_comment/create_comment.dart';
import 'package:swaptime_flutter/module_comment/response/comment/create_comment_response.dart';

@provide
class CommentManager {
  final CommentRepository _commentRepository;
  CommentManager(this._commentRepository);

  Future<CreateCommentResponse> createComment(
      CreateCommentRequest commentRequest) {
    return _commentRepository.createComment(commentRequest);
  }
}
