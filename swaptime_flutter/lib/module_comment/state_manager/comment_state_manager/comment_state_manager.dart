import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_comment/service/comment_service/comment_service.dart';
import 'package:swaptime_flutter/module_comment/states/comment_states/comment_states.dart';

@provide
class CommentStateManager {
  final PublishSubject<CommentState> _stateSubject = PublishSubject();
  Stream<CommentState> get stateStream => _stateSubject.stream;

  final CommentService _service;
  CommentStateManager(this._service);

  void getComments(String gameId) {
    _service.getComments(gameId).then((value) {
      _stateSubject.add(CommentStateLoadSuccess(value));
    });
  }

  void postComment(String gameId, String commentMsg) {
    _service.postComment(gameId, commentMsg).then((value) {
      getComments(gameId);
    });
  }
}
