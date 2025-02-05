import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 41);  // Start se bottom left tak line kheenchna
    path.quadraticBezierTo(
      size.width / 4, size.height / 4,
      size.width, size.height,
    );  // Bezier curve ke zariye right side tak pohanchna
    path.lineTo(size.width, 0);  // Top right tak line kheenchna
    path.close();  // Path ko band karna
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;  // Har dafa path ko recalculate nahi karna
  }
}
