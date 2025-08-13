



import 'package:hive/hive.dart';

class HiveManager {
  static const String _boxName = "AppBox";
  static Box? _box;


  static Future<void> init()async{
    if(!Hive.isBoxOpen(_boxName)){
      _box = await Hive.openBox(_boxName);
    }else{
      _box = Hive.box(_boxName);
    }
  }

  static Future<void> putString(String key, String value)async{
    await _box?.put(key, value);
  }

  static String getString(String key) {
    return _box?.get(key, defaultValue: '') ?? '';
  }

  static Future<void> putBool(String key, bool value) async {
    await _box?.put(key, value);
  }

  static bool getBool(String key) {
    return _box?.get(key, defaultValue: false) ?? false;
  }

  static Future<void> putInt(String key, int value) async {
    await _box?.put(key, value);
  }

  static int getInt(String key) {
    return _box?.get(key, defaultValue: 0) ?? 0;
  }

  static Future<void> remove(String key) async {
    await _box?.delete(key);
  }

  static Future<void> clear() async {
    await _box?.clear();
  }

}