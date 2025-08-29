import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static SharedPreferences _preferences = _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setString(String key, String value) async => await _preferences.setString(key, value);

  static String getString(String key) => _preferences.getString(key) ?? '';

  static Future setBoolean(String key, bool value) async => await _preferences.setBool(key, value);

  static bool getBoolean(String key) => _preferences.getBool(key) ?? false;

  static void clearPref() {
    _preferences.clear();
  }

  static int getInt(dynamic key) {
    return _preferences.getInt("$key") ?? 0;
  }

  static double getDouble(String key) => _preferences.getDouble(key) ?? 0.0;


  static Future setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  static Future setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  static Future<bool>? remove(String key) {
    // ignore: unnecessary_null_comparison
    if (_preferences == null) return null;
    return _preferences.remove(key);
  }
}
