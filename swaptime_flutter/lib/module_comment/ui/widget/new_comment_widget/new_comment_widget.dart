import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

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
                    hintText: S.of(context).thisGameIsGreat,
                    labelText: S.of(context).comment),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: SwapThemeDataService.getAccent(),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                if (_newCommentController.text.length > 3) {
                  onCommentPost(_newCommentController.text);
                  _newCommentController.clear();
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).emptyComment),
                  ));
                }
              }),
        )
      ],
    );
  }
}
