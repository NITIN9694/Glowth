
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infra/utills/base_view.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_size.dart';
import '../../../style/app_style.dart';
import '../login_controller.dart';

class  GenderPage extends BaseView<LoginController> {
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
          Text("Select Your Gender",
            style: boldTextStyle(fontSize: dimen32, color: AppColors.colorWhite),
          ),

          SizedBox(
            height: 20.h,
          ),

          Obx(()=>  GestureDetector(
            onTap: (){
              controller.isMale.value=0;
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorB13BFF.withOpacity(0.2), // shadow color
                    blurRadius: 10, // how soft the shadow is
                    spreadRadius: 2, // how far the shadow spreads
                    offset: Offset(0, 5), // x,y offset from the container
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color:controller.isMale.value==0? AppColors.colorWhite:AppColors.color090040,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        color: controller.isMale.value==0? AppColors.color090040:AppColors.colorWhite,
                        shape: BoxShape.circle
                      // shape: BoxShape.circle
                    ),
                    child:
                    Icon(Icons.male,
                      size: 30.h,
                      color: controller.isMale.value==0? AppColors.colorWhite:AppColors.color090040,
                    ),
                  ),
                  Text("Male",
                      style: mediumTextStyle(fontSize: dimen26, color:  controller.isMale.value==0? AppColors.color090040:AppColors.colorWhite,)
                  )
                ],
              ),
            ),
          ),),
          Obx(()=>  GestureDetector(
            onTap: (){
              controller.isMale.value=1;
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:controller.isMale.value==1? AppColors.colorWhite:AppColors.color090040,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        color: controller.isMale.value==1? AppColors.color090040:AppColors.colorWhite,
                        shape: BoxShape.circle
                      // shape: BoxShape.circle
                    ),
                    child:
                    Icon(Icons.female,
                      size: 30.h,
                      color: controller.isMale.value==1? AppColors.colorWhite:AppColors.color090040,
                    ),
                  ),
                  Text("Female",
                      style: mediumTextStyle(fontSize: dimen26, color:  controller.isMale.value==1? AppColors.color090040:AppColors.colorWhite,)
                  )
                ],
              ),
            ),
          ),),
          Spacer(),



      ]),
   );

  }
}