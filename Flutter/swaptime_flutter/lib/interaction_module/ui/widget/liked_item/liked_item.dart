import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';

class LikedItemCard extends StatelessWidget {
  final String ownerFirstName;
  final String ownerImageUrl;
  final String gameImageUrl;
  final String date;

  LikedItemCard(
      {@required this.ownerFirstName,
      @required this.gameImageUrl,
      @required this.date,
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
                  Positioned.directional(
                    bottom: 8,
                    end: 8,
                    textDirection: Directionality.of(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            date.length > 5
                                ? Text(S.of(context).likedAt + ' ' + date)
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.send),
                            ),
                          ],
                        ),
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
