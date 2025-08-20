import 'package:get/get.dart';
import 'package:glowth/infra/local_storage/app_constant.dart';
import 'package:glowth/infra/local_storage/pref_manager.dart';

import '../../infra/model/skin_data_model.dart';

class SkinDataController extends GetxController {
  var userName = "".obs;

  SkinDataModel skinData = SkinDataModel();
  var imagePath = "".obs;

    var visibleStep = 0.obs;

  @override
  void onInit() {
    Future.delayed(Duration.zero, () async {
      userName.value = HiveManager.getString(AppConstant().username);
    });
    skinData = Get.arguments[0] as SkinDataModel;
    imagePath.value = Get.arguments[1];

    _showSteps();
    super.onInit();
  }

   void _showSteps() async {
    for (int i = 0; i < 5; i++) { // 3 sections for example
      await Future.delayed(const Duration(seconds: 2));
     
        visibleStep.value = i + 1;
    
    }
  }
}
