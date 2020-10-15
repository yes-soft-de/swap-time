import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  CommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(commentModel.userImage),
                    ),
                  ),
                ),
                Text(commentModel.username)
              ],
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(commentModel.comment),
        ))
      ],
    );
  }
}
