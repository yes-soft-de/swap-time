import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: Offset.fromDirection(90),
                color: Colors.grey),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    height: 32,
                    width: 32,
                    child: SvgPicture.asset('assets/images/logo.svg')),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  'Mohammad and 7 Others Liked this project ;)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
