import 'package:flutter/material.dart';
import 'package:glowth/screens/home_screen/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowth/screens/login/login_screen.dart';
import 'package:get/get.dart';
import 'infra/navigation/navigation.dart';
import 'infra/navigation/routes.dart';
import 'initializer.dart';


void main() async{
  await Initializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          initialRoute: Routes.login,
          getPages: Nav.routes,
            theme: ThemeData(

              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          home: LoginScreen(),
          builder: (context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaleFactor: 1.1),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
        ),


       );

  }
}

