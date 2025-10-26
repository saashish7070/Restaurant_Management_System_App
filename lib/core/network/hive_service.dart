import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<void> putData<T>(String boxName, String key, T value) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
  }

  Future<T?> getData<T>(String boxName, String key) async {
    final box = await Hive.openBox<T>(boxName);
    return box.get(key);
  }

  Future<void> deleteData(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
