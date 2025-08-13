import 'package:get/get.dart';
import 'package:glowth/screens/scan_face/scan_face_controller.dart';

class ScanFaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanFaceController>(() => ScanFaceController());
  }

}