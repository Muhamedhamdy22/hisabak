import 'package:shared_preferences/shared_preferences.dart';
import 'package:hisabak/core/constants/app_constants.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static Future<void> saveToken(String token) async {
    await _prefs?.setString(AppConstants.keyToken, token);
  }

  static String? getToken() {
    return _prefs?.getString(AppConstants.keyToken);
  }

  static Future<void> removeToken() async {
    await _prefs?.remove(AppConstants.keyToken);
  }

  static bool isLoggedIn() {
    return _prefs?.getString(AppConstants.keyToken) != null;
  }


  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}