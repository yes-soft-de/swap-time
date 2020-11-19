import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comment_widget/comment_widget.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/new_comment_widget/new_comment_widget.dart';

class CommentListWidget extends StatelessWidget {
  final String userId;
  final List<CommentModel> commentList;
  final Function(String newComment) onCommentAdded;

  CommentListWidget(this.commentList, [this.onCommentAdded, this.userId]);

  @override
  Widget build(BuildContext context) {
    List<Widget> commentWidgetLines = [];
    commentList.forEach((element) {
      if (element.comment.length > 2) {
        commentWidgetLines.add(CommentWidget(element));
      }
    });
    if (commentWidgetLines.isEmpty) {
      commentWidgetLines.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
        child: Text(S.of(context).beTheFirstToComment),
      ));
    }
    if (userId != null) {
      commentWidgetLines.add(NewCommentWidget((newComment) {
        onCommentAdded(newComment);
      }));
    } else if (onCommentAdded != null) {
      commentWidgetLines.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.pink),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 44,
                child: Text(
                  S.of(context).login,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return Flex(
      direction: Axis.vertical,
      children: commentWidgetLines,
    );
  }
}
