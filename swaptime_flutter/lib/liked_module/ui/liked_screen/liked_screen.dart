import 'package:flutter/material.dart';
import 'package:swaptime_flutter/liked_module/ui/widget/liked_item/liked_item.dart';

class LikedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
        LikedItemCard(
          gameImageUrl: 'https://i.ytimg.com/vi/RQEOwEBvC-M/maxresdefault.jpg',
          ownerFirstName: 'Osama',
        ),
      ],
    );
  }
}
