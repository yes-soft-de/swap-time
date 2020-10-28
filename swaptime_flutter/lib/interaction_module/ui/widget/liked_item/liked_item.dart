import 'package:flutter/material.dart';

class LikedItemCard extends StatelessWidget {
  final String ownerFirstName;
  final String ownerImageUrl;
  final String gameImageUrl;

  LikedItemCard(
      {@required this.ownerFirstName,
      @required this.gameImageUrl,
      this.ownerImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/logo.jpg',
                    image: ownerImageUrl ??
                        'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/link_broken.png',
                  ),
                  Text(
                    ownerFirstName,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      gameImageUrl ??
                          'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/link_broken.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.send),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
