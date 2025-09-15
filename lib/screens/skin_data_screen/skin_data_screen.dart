import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glowth/screens/skin_data_screen/skin_data_controller.dart';
import 'package:glowth/style/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowth/style/app_size.dart';
import 'package:glowth/style/app_style.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../infra/utills/base_view.dart';

class SkinDataScreen extends BaseView<SkinDataController> {
  SkinDataScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.color090040,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),

                  GestureDetector(
                    onTap: () {
                      Get.back(result: true);
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                        size: 24.h,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Text(
                  //       "Hii ${controller.userName.value}",
                  //       style: boldTextStyle(
                  //         fontSize: dimen18,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  SizedBox(height: 15.h),
                  Container(
                    height: 300.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(controller.imagePath.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),
                  controller.visibleStep.value >= 1
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Skin Type",
                            style: boldTextStyle(
                              fontSize: dimen18,
                              color: Colors.white, 
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(4.h),
                            margin: EdgeInsets.symmetric(vertical: 10.w),
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                              color: AppColors.primaryGold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                " ${controller.skinData.skinType.toString().toUpperCase()}",
                                style: mediumTextStyle(
                                  fontSize: dimen14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 140.w,
                          height: 30.h,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  SizedBox(height: 5.h),
                  controller.visibleStep.value >= 2
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Face Shape",
                            style: boldTextStyle(
                              fontSize: dimen18,
                              color: Colors.white,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(4.h),
                            margin: EdgeInsets.symmetric(vertical: 10.w),
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                              color: AppColors.color113F67,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                " ${controller.skinData.faceShape.toString().toUpperCase()}",
                                style: mediumTextStyle(
                                  fontSize: dimen14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 140.w,
                          height: 30.h,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  SizedBox(height: 5.h),

                  controller.visibleStep.value >= 3
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skin Care Product",
                            style: boldTextStyle(
                              fontSize: dimen18,
                              color: Colors.white,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.skinData.skincareByGender!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(vertical: 6.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.indigo[(index % 9 + 1) * 100],
                                ),

                                child: GestureDetector(
                                  onTap: () async {
                                    await controller.launchProductSearch(
                                      controller
                                          .skinData
                                          .skincareByGender![index]
                                          .name
                                          .toString(),
                                      true,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.skinData.skincareByGender![index].name}: \n${controller.skinData.skincareByGender![index].description}.",
                                              style: mediumTextStyle(
                                                fontSize: dimen14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              "${controller.skinData.skincareByGender![index].application}"
                                                  .toUpperCase(),
                                              style: mediumTextStyle(
                                                fontSize: dimen14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          controller
                                              .skinData
                                              .skincareByGender![index]
                                              .imageUrl
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: 130,
                                          width: 130,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Container(
                                              height: 100,
                                              width: 120,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey.withOpacity(
                                                  0.4,
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 6.h),

                              width: double.infinity,
                              height: 60.h,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),

                  controller.visibleStep.value >= 4
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          Text(
                            "Hairstyle Recommendations",
                            style: boldTextStyle(
                              fontSize: dimen18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Avoid ${controller.skinData.hairstyleTips!.avoid.toString()} use product like",
                            style: regularTextStyle(
                              fontSize: dimen14,
                              color: Colors.white,
                            ),
                          ),
                          Wrap(
                            spacing: 8, // horizontal gap
                            runSpacing: 8, // vertical gap
                            children:
                                controller
                                    .skinData
                                    .hairstyleTips!
                                    .recommendedProducts!
                                    .map(
                                      (tag) => Text(
                                        "$tag,",
                                        style: regularTextStyle(
                                          fontSize: dimen14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      )
                      : Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          width: double.infinity,
                          height: 60.h,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                  SizedBox(height: 20.h),
                  controller.visibleStep.value >= 5
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hair Cutting Recommendations",
                            style: boldTextStyle(
                              fontSize: dimen18,
                              color: Colors.white,
                            ),
                          ),

                          MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2, // number of columns
                            mainAxisSpacing: 20,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 20,
                            padding: const EdgeInsets.all(8),
                            itemCount: controller.skinData.hairstyles?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await controller.launchProductSearch(
                                    controller.skinData.hairstyles?[index].name
                                            .toString() ??
                                        "",
                                    false,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[(index % 9 + 1) * 100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // different heights
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image.network(
                                        //   controller
                                        //           .skinData
                                        //           .hairstyles![index]
                                        //           .imageUrl
                                        //           .toString() ??
                                        //       "",
                                        // ),
                                        Text(
                                          controller
                                                  .skinData
                                                  .hairstyles![index]
                                                  .name
                                                  .toString() ??
                                              "",
                                          style: mediumTextStyle(
                                            fontSize: dimen22,
                                            color: Colors.white,
                                          ),
                                        ),

                                        Text(
                                          controller
                                                  .skinData
                                                  .hairstyles![index]
                                                  .description
                                                  .toString() ??
                                              "",
                                          style: regularTextStyle(
                                            fontSize: dimen11,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),

                                        Text(
                                          "Hair Type",
                                          style: boldTextStyle(
                                            fontSize: dimen14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Wrap(
                                          spacing: 8, // horizontal gap
                                          runSpacing: 8, // vertical gap
                                          children:
                                              controller
                                                  .skinData
                                                  .hairstyles![index]
                                                  .hairType!
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (tag) => Text(
                                                      "${tag.key + 1}. ${tag.value}",
                                                      style: regularTextStyle(
                                                        fontSize: dimen13,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                      : MasonryGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2, // number of columns
                        mainAxisSpacing: 20,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 20,
                        padding: const EdgeInsets.all(8),
                        itemCount: controller.skinData.hairstyles?.length,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              width: double.infinity,
                              height: 120.h,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
