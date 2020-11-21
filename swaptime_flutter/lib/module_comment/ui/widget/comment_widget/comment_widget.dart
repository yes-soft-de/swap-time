import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  CommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return commentModel.profile == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: .25)),
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: commentModel.profile != null
                                ? NetworkImage(commentModel.profile.image)
                                : AssetImage('assets/images/logo.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(commentModel.profile.userName),
                              Text(calcDifference(
                                  commentModel.date.timestamp, context)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            commentModel.comment,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  String calcDifference(int timestamp, BuildContext context) {
    var sentDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = DateTime.now().difference(sentDate);

    if (DateTime.now().difference(sentDate).inMinutes < 60) {
      var minutes = diff.inMinutes;
      return minutes.toString() + ' ' + S.of(context).minutesAgo;
    } else if (diff.inHours < 24) {
      return diff.inHours.toString() + ' ' + S.of(context).hoursAgo;
    } else {
      return sentDate.toString().substring(0, 10);
    }
  }
}
