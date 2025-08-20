import 'package:flutter/material.dart';

import 'face_mesh_painter.dart';


class FaceScanAnimation extends StatefulWidget {
  final List<Offset> facePoints;
  final double originalWidth;
  final double originalHeight;

  const FaceScanAnimation({
    Key? key,
    required this.facePoints,
    required this.originalWidth,
    required this.originalHeight,
  }) : super(key: key);

  @override
  _FaceScanAnimationState createState() => _FaceScanAnimationState();
}

class _FaceScanAnimationState extends State<FaceScanAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: FaceMeshPainter(
            widget.facePoints,
            widget.originalWidth,
            widget.originalHeight,
            _animation.value,
          ),
          child: Container(),
        );
      },
    );
  }
}
