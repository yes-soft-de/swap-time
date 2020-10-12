import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/state_manager/comment_state_manager/comment_state_manager.dart';
import 'package:swaptime_flutter/module_comment/states/comment_states/comment_states.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comment_widget/comment_widget.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/new_comment_widget/new_comment_widget.dart';

@provide
class CommentListWidget extends StatefulWidget {
  final CommentStateManager _manager;
  final AuthService _authService;

  CommentListWidget(this._manager, this._authService);

  @override
  State<StatefulWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  CommentState currentState;
  String gameId;

  @override
  void initState() {
    super.initState();
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    gameId = ModalRoute.of(context).settings.arguments;
    if (!(currentState is CommentStateLoadSuccess)) {
      widget._manager.getComments(gameId);
    }
    if (currentState is CommentStateLoadSuccess) {
      CommentStateLoadSuccess state = currentState;
      List<Widget> commentLines = [];
      state.commentList.forEach((element) {
        commentLines.add(CommentWidget(element));
      });
      if (commentLines.isEmpty) {
        commentLines.add(Padding(
          padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
          child: Text(S.of(context).beTheFirstToComment),
        ));
      }
      widget._authService.isLoggedIn
        ..then((loggedIn) {
          if (loggedIn) {
            commentLines.add(NewCommentWidget((newComment) {
              widget._manager.postComment(gameId, newComment);
            }));
          } else {
            commentLines.add(Container(
              decoration: BoxDecoration(color: Colors.pink),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).login),
                ],
              ),
            ));
          }
        });

      return Flex(
        direction: Axis.vertical,
        children: commentLines,
      );
    }
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
