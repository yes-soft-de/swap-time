import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  CommentWidget(this.commentModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
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
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 1,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black54
                  : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
