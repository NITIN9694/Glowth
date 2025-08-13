
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

import 'infra/api_service/log.dart';
import 'infra/local_storage/pref_manager.dart';



class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      await HiveManager.init();

      _initLog();
      _initScreenPreference();
    } catch (err) {
      rethrow;
    }
  }

  static _initLog() {
    Log.init();
    Log.setLevel(Level.ALL);
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
