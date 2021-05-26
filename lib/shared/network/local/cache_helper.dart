import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants.dart';

class CacheHelper {
  // save data in cache
  static Future<void> saveData({String key, bool value, String token}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (key == kToken) {
      await sharedPreferences.setString(kToken, token);
    } else {
      await sharedPreferences.setBool(key, value);
    }
  }

  // get data from cache
  static Future<dynamic> getData({String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var value;
    if (key == kToken) {
      value = sharedPreferences.getString(key);
      if (value != null) {
        return value;
      } else {
        return '';
      }
    } else {
      value = sharedPreferences.getBool(key);
      if (value != null) {
        return value;
      } else {
        return false;
      }
    }
  }

  // delete data in cache
  static Future<bool> deleteData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(kToken);
  }
}
