import 'package:flutter/material.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_news/notification_news.dart';
import 'package:swaptime_flutter/module_notifications/ui/widget/notification_ongoing/notification_ongoing.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        NotificationOnGoing(
          myGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirName: 'Mohammad',
        ),
        NotificationOnGoing(
          myGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirName: 'Mohammad',
        ),
        NotificationNews(),
        NotificationOnGoing(
          theirGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirName: 'Mohammad',
        ),
        NotificationOnGoing(
          myGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirGameUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          theirName: 'Mohammad',
        ),
      ],
    );
  }
}
