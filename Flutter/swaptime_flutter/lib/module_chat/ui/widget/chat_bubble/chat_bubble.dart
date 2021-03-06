import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';

class ChatBubbleWidget extends StatefulWidget {
  final bool showImage;
  final String message;
  final String sentDate;
  final bool me;

  ChatBubbleWidget({
    Key key,
    this.message,
    this.sentDate,
    this.me,
    this.showImage,
  });

  @override
  State<StatefulWidget> createState() => ChatBubbleWidgetState();
}

class ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.me ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(calcDifference(widget.sentDate)),
                widget.message.contains('http')
                    ? Image.network(widget.message)
                    : Text(
                        '${widget.message}',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calcDifference(String date) {
    DateTime sentDate = DateTime.parse(date);
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
