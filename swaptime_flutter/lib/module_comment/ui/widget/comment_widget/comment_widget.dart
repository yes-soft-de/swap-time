import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  CommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: .25)
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(commentModel.profile.image),
                        ),
                      ),
                    ),
                    Text(commentModel.profile.userName)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(commentModel.comment),
            ),
          ],
        ),
      ),
    );
  }
}
