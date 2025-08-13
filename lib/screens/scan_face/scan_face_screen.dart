

import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glowth/infra/utills/base_view.dart';
import 'package:glowth/screens/scan_face/scan_face_controller.dart';
import 'package:camera/camera.dart';
import 'package:glowth/screens/scan_face/widgets/face_mesh_painter.dart';
class ScanFaceScreen extends BaseView<ScanFaceController>{


  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Scaffold(
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return controller.selectedImagePath.value.isNotEmpty?  _selectedImageWidget():_cameraPreview();
      }),
    );
  }

  _selectedImageWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Image.file(
              File(controller.selectedImagePath.value),
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 50,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  print("thi");
                  controller.selectedImagePath.value = "";


                },
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Icon(CupertinoIcons.back, size: 24.h, color: Colors.white),
                ),
              ),
            ),

            GetBuilder<ScanFaceController>(
              builder: (_) {
             return   IgnorePointer(
                    ignoring: true,

                child:  CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: FaceMeshPainter(
                    controller.facePoints,
                    controller.originalImageWidth.value,
                    controller.originalImageHeight.value,
                  ),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _bottomProductPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Daily Activity", style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _productCard("Revive Eye Serum"),
                _productCard("Bean Stick Balm"),
                _productCard("Cream"),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _productCard(String title) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text(title, textAlign: TextAlign.center)),
    );
  }
  _cameraPreview() {
    return Stack(
      children: [
        // Full screen camera preview
        Positioned.fill(
          child: CameraPreview(controller.cameraController!),
        ),

        // Bottom controls
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Capture button in center
              GestureDetector(
                onTap: controller.capturePhoto,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.8),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.camera_alt, size: 36, color: Colors.black),
                ),
              ),
            ],
          ),
        ),

        // Gallery button on bottom right
        Positioned(
          bottom: 50,
          right: 30,
          child: GestureDetector(
            onTap: controller.checkPermissionsGallary,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.photo, size: 32, color: Colors.black),
            ),
          ),
        ),

        Positioned(
          bottom: 50,
          left: 30,
          child: GestureDetector(
            onTap: controller.flipCamera,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child:  Icon( CupertinoIcons.camera_rotate_fill, size: 32, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }


  Widget skinTypeChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }
}

class FaceScanOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Mock: Draw rectangle and a few points
    final faceRect = Rect.fromLTWH(size.width * 0.2, size.height * 0.2, size.width * 0.6, size.height * 0.6);
    canvas.drawRect(faceRect, paint);

    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 8; i++) {
      canvas.drawCircle(
        Offset(faceRect.left + (i % 4) * (faceRect.width / 3), faceRect.top + (i ~/ 4) * faceRect.height),
        4,
        pointPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}