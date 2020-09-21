import 'package:flutter/material.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class NewCommentWidget extends StatelessWidget {
  final TextEditingController _newCommentController = TextEditingController();
  final Function(String) onCommentPost;
  NewCommentWidget(this.onCommentPost);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: TextFormField(
                controller: _newCommentController,
                decoration: InputDecoration(
                    hintText: 'This Game is Great',
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Comment'),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: SwapThemeData.getAccent(),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              onCommentPost(_newCommentController.text);
              _newCommentController.clear();
            },
          ),
        )
      ],
    );
  }
}
