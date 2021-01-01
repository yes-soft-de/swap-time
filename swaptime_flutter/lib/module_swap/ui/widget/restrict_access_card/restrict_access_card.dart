import 'package:flutter/material.dart';

class RestrictAccessCard extends StatelessWidget {
  final String image;
  final bool restricted;
  final int productId;
  final Function(int) onProductPressed;

  RestrictAccessCard({
    @required this.image,
    @required this.restricted,
    @required this.productId,
    @required this.onProductPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: GestureDetector(
        onTap: () {
          onProductPressed(productId);
        },
        child: Stack(
          children: [
            FadeInImage.assetNetwork(
              placeholder: '/assets/images/logo.jpg',
              image: image,
            ),
            restricted == true
                ? Positioned.fill(
                    child: Container(
                    color: Colors.black38,
                    child: Center(
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
