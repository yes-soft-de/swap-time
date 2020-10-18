import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/manager/comment_manager/comment_manager.dart';
import 'package:swaptime_flutter/module_comment/request/create_comment/create_comment.dart';
import 'package:swaptime_flutter/module_comment/response/comment/create_comment_response.dart';

@provide
class CommentService {
  final AuthService _authService;
  final CommentManager _commentManager;
  CommentService(
    this._authService,
    this._commentManager,
  );

  Future<CreateCommentResponse> postComment(
      int gameId, String commentMsg) async {
    String uid = await _authService.userID;
    CreateCommentRequest commentRequest = CreateCommentRequest(
        comment: commentMsg,
        userID: uid,
        date: DateTime.now().toIso8601String(),
        swapItemID: gameId);

    var newComment = await _commentManager.createComment(commentRequest);

    return newComment;
  }
}
