import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glowth/infra/local_storage/app_constant.dart';
import 'package:glowth/infra/local_storage/pref_manager.dart';
import 'package:glowth/infra/navigation/routes.dart';
import 'package:glowth/screens/login/login_controller.dart';
import 'package:glowth/screens/login/widget/gender_page.dart';
import 'package:glowth/screens/login/widget/login_next_button.dart';
import 'package:glowth/screens/login/widget/name_page.dart';
import 'package:glowth/style/app_colors.dart';
import 'package:glowth/style/app_size.dart';
import 'package:glowth/style/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../infra/utills/base_view.dart';

class LoginScreen extends BaseView<LoginController> {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Widget> pages = [GenderPage(), NamePage()];

  LoginScreen({super.key});

  void goToNextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Scaffold(
      backgroundColor: AppColors.color090040,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(), // disable swipe
              onPageChanged: (index) {
                currentPage.value = index;
              },
              children: pages,
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (currentPage.value == 0) {
                      goToNextPage();
                    } else {
                      await HiveManager.putString(
                        AppConstant().username,
                        controller.nameController.text,
                      );
                      await HiveManager.putString(
                        AppConstant().gender,
                        controller.isMale.value == 0 ? "Male" : "Female",
                      );

                      Get.offAllNamed(Routes.scanFace);
                    }
                  },

                  child:
                      currentPage.value == 0
                          ? ArrowButtonAnimation()
                          : SubmitButtonAnimation(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
