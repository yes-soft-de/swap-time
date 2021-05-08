import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comment_widget/comment_widget.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/new_comment_widget/new_comment_widget.dart';

class CommentListWidget extends StatelessWidget {
  final bool isLoggedIn;
  final List<CommentModel> commentList;
  final Function(String newComment) onCommentAdded;

  CommentListWidget({this.commentList, this.onCommentAdded, this.isLoggedIn});


  @override
  Widget build(BuildContext context) {
    List<Widget> commentWidgetLines = [];
    commentList.forEach((element) {
      if (element.comment.isNotEmpty) {
        commentWidgetLines.add(CommentWidget(element));
      }
    });
    if (commentWidgetLines.isEmpty) {
      commentWidgetLines.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
        child: Text(S.of(context).beTheFirstToComment),
      ));
    }
    if (isLoggedIn == true) {
      commentWidgetLines.add(NewCommentWidget(
        onCommentPost: (newComment) {
          commentList.add(CommentModel(
            comment: newComment,
            date: Date(timestamp: DateTime.now().millisecondsSinceEpoch),
          ));
          onCommentAdded(newComment);
        },
      ));
    } else {
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

