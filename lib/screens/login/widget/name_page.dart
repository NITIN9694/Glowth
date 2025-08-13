
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infra/utills/base_view.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_size.dart';
import '../../../style/app_style.dart';
import '../login_controller.dart';

class  NamePage extends BaseView<LoginController> {
  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Scaffold(
      backgroundColor: AppColors.color090040,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Spacer(),
            Text("Enter Your Name",
              style: boldTextStyle(fontSize: dimen32, color: AppColors.colorWhite),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
              controller: controller.nameController,
              style: mediumTextStyle(fontSize: dimen16, color:  AppColors.colorWhite),
              decoration: InputDecoration(
                hintText: "Enter your text",
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:  BorderSide(color: AppColors.colorWhite, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: AppColors.colorWhite, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color:  AppColors.colorWhite, width: 2),
                ),
              ),
            ),


            SizedBox(
              height: 20.h,
            ),


            Spacer(),



          ]),
    );

  }
}