import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glowth/infra/utills/base_view.dart';
import 'package:glowth/screens/home_screen/home_controller.dart';
import 'package:glowth/style/app_colors.dart';
import 'package:glowth/style/app_size.dart';
import 'package:glowth/style/app_style.dart';

class HomeScreen extends BaseView<HomeController>{
  @override
  Widget body(BuildContext context) {
    // TODO: implement body
   return SafeArea(
     child: Scaffold(
       backgroundColor: AppColors.colorC6E7FF.withOpacity(0.4),
       body: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.w),
         child: Column(
           children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hello,Nitin\nGood Morning",
                  style: mediumTextStyle(fontSize: dimen18, color: AppColors.color2C2C2E),
                ),

              ],
            ),
             SizedBox(
               height: 25.h,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text("Daily Activity",
                 style: mediumTextStyle(fontSize: dimen18, color: AppColors.onyxBlack),
                 ),
                 Text("View All",
                   style: mediumTextStyle(fontSize: dimen18, color: AppColors.onyxBlack),
                 ),
               ],
             ),
             SizedBox(
               height: 10.h,
             ),

             Container(
               height: 70.h,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                 color: Colors.white
               ),
               child: ListView.builder(
                 itemCount: 5,

                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index){

                 return  Column(
                   children: [
                     Row(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             index==0? SizedBox():   Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Container(
                                   height: 3,
                                   width: 10,
                                   decoration: BoxDecoration(
                                       color:AppColors.onyxBlack
                                   ),

                                 ),
                                 SizedBox(
                                   width: 10,
                                 ),
                                 Container(
                                   height: 3,
                                   width: 10,
                                   decoration: BoxDecoration(
                                       color: AppColors.onyxBlack
                                   ),

                                 ),
                               ],
                             ),

                           ],
                         ),
                         Container(
                             margin: EdgeInsets.all(10),
                             padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(

                                 color:index==3||index==4 || index==2?AppColors.colorC6E7FF.withOpacity(0.4):AppColors.colorF5CBCB,
                                 shape: BoxShape.circle
                             ),

                             child:index==3||index==4 || index==2?
                             Icon(Icons.remove)
                                 :Icon(Icons.done,color: Colors.white,)
                         ),
                       ],
                     ),

                     Text("Day ${(index+1).toString()}",
                       style: mediumTextStyle(fontSize: dimen12, color: AppColors.onyxBlack),
                     )
                   ],
                 );
               }),
             ),
             SizedBox(
               height: 40.h,
             ),


             SizedBox(
               height: 40.h,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 physics: BouncingScrollPhysics(),
                 itemCount: controller.categoryList.length,
                 itemBuilder: (BuildContext context,int index){
                   return    Obx(()=>Center(
                     child: GestureDetector(
                       onTap: (){
                         controller.onTapCategory.value  = index;
                       },
                       child: Container(
                         padding: EdgeInsets.all(10.r),
                         margin: EdgeInsets.symmetric(horizontal: 10.w),

                         decoration: BoxDecoration(
                             border: Border.all(color: AppColors.onyxBlack.withOpacity(0.2),width: 1),
                             borderRadius: BorderRadius.circular(20.r),
                             color:controller.onTapCategory.value==index?AppColors.onyxBlack: Colors.white
                         ),
                         child: Center(
                           child: Text(controller.categoryList[index].toString(),

                             style: mediumTextStyle(fontSize: dimen15, color:  controller.onTapCategory.value==index?
                             AppColors.colorWhite:AppColors.onyxBlack),
                           ),
                         ),
                       ),
                     ),
                   ));
                 },

               ),
             ),
             SizedBox(
               height: 40.h,
             ),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: GridView.builder(
                   itemCount: controller.products.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 16,
                     crossAxisSpacing: 12,
                     childAspectRatio: 0.8,
                   ),
                   itemBuilder: (context, index) {
                     return Container(
                       decoration: BoxDecoration(
                         color: AppColors.colorC6E7FF,
                         borderRadius: BorderRadius.circular(20),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black12,
                             blurRadius: 10,
                             spreadRadius: 2,
                           ),
                         ],
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Expanded(
                             child: ClipRRect(

                               borderRadius: const BorderRadius.vertical(
                                   top: Radius.circular(20)),
                               child: Image.network(
                                 controller. products[index]["image"]!,
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           const SizedBox(height: 8),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               controller.products[index]["name"]!,
                               textAlign: TextAlign.center,
                               style: mediumTextStyle(fontSize: dimen12,color: AppColors.onyxBlack),
                             ),
                           ),
                         ],
                       ),
                     );
                   },
                 ),
               ),
             ),

           ],
         ),
       ),
     ),
   );
  }

}