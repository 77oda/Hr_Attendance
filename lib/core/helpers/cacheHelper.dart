import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static dynamic getData({required String key}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key);
  }
}
