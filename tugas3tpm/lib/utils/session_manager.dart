import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';
  
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> isLoggedIn() async {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> login(String username) async {
    await _prefs.setBool(_isLoggedInKey, true);
    await _prefs.setString(_usernameKey, username);
  }

  static Future<void> logout() async {
    await _prefs.remove(_isLoggedInKey);
    await _prefs.remove(_usernameKey);
  }

  static String? getUsername() {
    return _prefs.getString(_usernameKey);
  }
}