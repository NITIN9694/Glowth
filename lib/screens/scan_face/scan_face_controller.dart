import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ScanFaceController extends GetxController {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  var isCameraInitialized = false.obs;
  var selectedImagePath = ''.obs;
  var facePoints = <Offset>[].obs;
  var originalImageWidth = 0.0.obs;
   var originalImageHeight =  0.0.obs;


   getOriginalImageHeightWidth(String path)async{
     final bytes = await File(path).readAsBytes();
     final decodedImage = img.decodeImage(bytes)!;
     originalImageWidth.value = decodedImage.width.toDouble();
     originalImageHeight.value = decodedImage.height.toDouble();
   }


  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    _checkPermissions();
  }


  Future<void> _checkPermissions() async {
    // Camera permission
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      cameraStatus = await Permission.camera.request();
    }



    // If permanently denied → open settings
    if (cameraStatus.isPermanentlyDenied ) {
      openAppSettings();
      return;
    }
    log("cameraStatus ${cameraStatus.isGranted}");
    // If granted
    if (cameraStatus.isGranted ) {
      await _initCamera();
    } else {
      Get.snackbar("Permission Denied", "Camera & Gallery access is required");
    }
  }

  Future<int> _getSdkInt() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt;
    }
    return 0; // Not Android
  }


  Future<bool> requestGalleryPermission() async {
    int sdk = await _getSdkInt();

    Permission permission;
    if (sdk >= 33) {
      permission = Permission.photos; // READ_MEDIA_IMAGES
    } else {
      permission = Permission.storage; // READ_EXTERNAL_STORAGE
    }

    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }

    // If permanently denied → open settings
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return status.isGranted;
  }



  Future<void> checkPermissionsGallary() async {


    if (await requestGalleryPermission()) {
      await pickFromGallery();
      // Open gallery picker here
    }else{
      openAppSettings();
    }

  }

  Future<void> _initCamera({CameraLensDirection cameraDirection = CameraLensDirection.front}) async {
    // While initializing, hide preview
    isCameraInitialized.value = false;

    // Dispose old controller
    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameras = await availableCameras();

    final selectedCamera = cameras!.firstWhere(
          (cam) => cam.lensDirection == cameraDirection,
      orElse: () => cameras!.first,
    );

    cameraController = CameraController(
      selectedCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController!.initialize();
      isCameraInitialized.value = true; // Only show preview after success
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }


  void flipCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    final isFront = cameraController!.description.lensDirection == CameraLensDirection.front;
    final newDirection = isFront
        ? CameraLensDirection.back
        : CameraLensDirection.front;

    await _initCamera(cameraDirection: newDirection);
  }


  var isCapturing = false.obs;


  Future<void> capturePhoto() async {
    if (isCapturing.value) return; // Prevent multiple clicks
    isCapturing.value = true;

    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        XFile picture = await cameraController!.takePicture();
        print('Photo captured: ${picture.path}');
        selectedImagePath.value = picture.path;
        await getOriginalImageHeightWidth(picture.path);
        await detectFace( selectedImagePath.value);
      }
    } catch (e) {
      print("Error capturing photo: $e");
    } finally {
      isCapturing.value = false;
    }
  }

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
      await getOriginalImageHeightWidth(image.path);
    await  detectFace( selectedImagePath.value);
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> detectFace(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final faces = await _faceDetector.processImage(inputImage);

    facePoints.clear();

    if (faces.isNotEmpty) {
      for (var face in faces) {
        if (face.contours[FaceContourType.face] != null) {
          facePoints.addAll(face.contours[FaceContourType.face]!.points.map(
                (p) => Offset(p.x.toDouble(), p.y.toDouble()),
          ));
        }
      }
    }
    update();
  }
}
