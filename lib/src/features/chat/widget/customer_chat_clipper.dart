import 'package:flutter/material.dart';

class CustomerChatClipper extends CustomClipper<Path> {
  final bool isSentByMe;

  CustomerChatClipper(this.isSentByMe);

  @override
  Path getClip(Size size) {
    var path = Path();
    double bubbleTipWidth = 25.0;

    if (isSentByMe) {
      // Bubble with tip on the right
      path.moveTo(0, 0);
      path.lineTo(size.width - bubbleTipWidth, 0);
      path.lineTo(size.width - bubbleTipWidth, size.height * 0.25);
      path.lineTo(size.width, size.height * 0.5);
      path.lineTo(size.width - bubbleTipWidth, size.height * 0.75);
      path.lineTo(size.width - bubbleTipWidth, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
      // Bubble with tip on the left
      path.moveTo(bubbleTipWidth, 0);
      path.lineTo(bubbleTipWidth, bubbleTipWidth);
      path.lineTo(0, size.height / 2);
      path.lineTo(bubbleTipWidth, size.height - bubbleTipWidth );
      path.lineTo(bubbleTipWidth, size.height - bubbleTipWidth );
      path.lineTo(bubbleTipWidth, size.height );
      path.lineTo(size.width, size.height );
      path.lineTo(size.width, 0 );
      path.close();

    }
    return path;
  }

  @override
  bool shouldReclip(CustomerChatClipper oldClipper) {
    return oldClipper.isSentByMe != isSentByMe;
  }
}