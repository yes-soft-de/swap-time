import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

@provide
class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  CommentService(this._authService);

  Future<CommentModel> postComment(String gameId, String commentMsg) async {
    String uid = await _authService.userID;
    CommentModel model = CommentModel(userId: uid, comment: commentMsg);
    await _firestore
        .collection('comments')
        .doc(gameId)
        .collection('comments')
        .add(model.toJson());
    return model;
  }

  Future<List<CommentModel>> getComments(String gameId) async {
    List<CommentModel> comments = [];
    var commentResponse = await _firestore
        .collection('comments')
        .doc(gameId)
        .collection('comments')
        .get();
    commentResponse.docs.forEach((element) {
      comments.add(CommentModel.fromJson(element.data()));
    });
    return comments;
  }
}
