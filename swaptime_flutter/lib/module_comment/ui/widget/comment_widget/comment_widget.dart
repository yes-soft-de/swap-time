import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  CommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      image: NetworkImage(commentModel.profile.image),
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
                        Text(DateTime.fromMillisecondsSinceEpoch(
                                        commentModel.date.timestamp * 1000)
                                    .difference(DateTime.now())
                                    .inHours <
                                24
                            ? DateTime.fromMillisecondsSinceEpoch(
                                    commentModel.date.timestamp * 1000)
                                .toString()
                                .substring(0, 10)
                            : DateTime.fromMillisecondsSinceEpoch(
                                        commentModel.date.timestamp * 1000)
                                    .difference(DateTime.now())
                                    .inHours
                                    .toString() +
                                ' ' +
                                S.of(context).minutesAgo),
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
}
