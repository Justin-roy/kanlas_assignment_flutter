import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Start from the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 30); // Define the curve
    path.lineTo(size.width, 0); // Close the path to form a container
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
