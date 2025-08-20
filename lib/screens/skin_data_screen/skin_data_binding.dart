import 'package:get/get.dart';
import 'package:glowth/screens/scan_face/scan_face_controller.dart';
import 'package:glowth/screens/skin_data_screen/skin_data_controller.dart';

class SkinDataBinding
    extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkinDataController>(() => SkinDataController());
  }

}