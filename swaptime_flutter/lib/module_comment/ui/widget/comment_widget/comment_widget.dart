import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/service/general_profile/general_profile.dart';

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
            child: FutureBuilder(
              future:
                  GeneralProfileService().getUserDetails(commentModel.userId),
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data.image),
                          ),
                        ),
                      ),
                      Text(snapshot.data.name)
                    ],
                  );
                } else {
                  return Container();
                }
              },
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
