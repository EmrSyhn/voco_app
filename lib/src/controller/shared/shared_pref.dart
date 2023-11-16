import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('token');
  }
}
