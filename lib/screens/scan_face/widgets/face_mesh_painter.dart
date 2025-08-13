import 'dart:ui';

import 'package:flutter/material.dart';

class FaceMeshPainter extends CustomPainter {
  final List<Offset> points;
  final double originalWidth;
  final double originalHeight;

  FaceMeshPainter(this.points, this.originalWidth, this.originalHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // Scale to fit screen
    double scaleX = size.width / originalWidth;
    double scaleY = size.height / originalHeight;

    for (var p in points) {
      canvas.drawCircle(
        Offset(p.dx * scaleX, p.dy * scaleY),
        2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FaceMeshPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
