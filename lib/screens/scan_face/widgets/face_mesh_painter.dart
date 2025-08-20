import 'dart:ui';
import 'package:flutter/material.dart';

class FaceMeshPainter extends CustomPainter {
  final List<Offset> points;
  final double originalWidth;
  final double originalHeight;
  final double scanPosition;

  FaceMeshPainter(
      this.points,
      this.originalWidth,
      this.originalHeight,
      this.scanPosition,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final pointPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final scanLinePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double scaleX = size.width / originalWidth;
    double scaleY = size.height / originalHeight;

    // Draw face mesh points
    for (var p in points) {
      canvas.drawCircle(
        Offset(p.dx * scaleX, p.dy * scaleY),
        2,
        pointPaint,
      );
    }

    // Draw scanning line (horizontal)
    double scanY = scanPosition * size.height;
    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      scanLinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant FaceMeshPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.scanPosition != scanPosition;
  }
}
