import 'package:shared_preferences/shared_preferences.dart';
import 'package:hisabak/core/constants/app_constants.dart';

class SharedPrefHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token
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

  // Language
  static Future<void> saveLang(String lang) async {
    await _prefs?.setString(AppConstants.keyLang, lang);
  }

  static String? getLang() {
    return _prefs?.getString(AppConstants.keyLang);
  }

  // Clear All
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}