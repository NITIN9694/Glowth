

import 'package:get/get.dart';
import 'package:glowth/screens/home_screen/home_binding.dart';
import 'package:glowth/screens/home_screen/home_screen.dart';
import 'package:glowth/screens/login/login_binding.dart';
import 'package:glowth/screens/login/login_screen.dart';
import 'package:glowth/screens/scan_face/scan_face_binding.dart';
import 'package:glowth/screens/scan_face/scan_face_screen.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.scanFace,
      page: () => ScanFaceScreen(),
      binding: ScanFaceBinding(),
    ),

  ];
}
