import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';
  static const String _favoriteSitesKey = 'favoriteSites'; // <-- tambahan favorit
  
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
    await _prefs.remove(_favoriteSitesKey); // <-- bersihkan juga favorit kalau logout
  }

  static String? getUsername() {
    return _prefs.getString(_usernameKey);
  }

  // ==== FAVORIT SECTION ====

  static Future<List<Map<String, dynamic>>> getFavoriteSites() async {
    final String? favoriteSitesJson = _prefs.getString(_favoriteSitesKey);
    if (favoriteSitesJson == null) return [];
    
    List<dynamic> decodedList = jsonDecode(favoriteSitesJson);
    return decodedList.cast<Map<String, dynamic>>();
  }

  static Future<void> addFavoriteSite(Map<String, dynamic> site) async {
    List<Map<String, dynamic>> currentFavorites = await getFavoriteSites();
    
    // Cek apakah sudah ada (berdasarkan URL)
    bool exists = currentFavorites.any((element) => element['url'] == site['url']);
    if (!exists) {
      currentFavorites.add(site);
      await _prefs.setString(_favoriteSitesKey, jsonEncode(currentFavorites));
    }
  }

  static Future<void> removeFavoriteSite(Map<String, dynamic> site) async {
    List<Map<String, dynamic>> currentFavorites = await getFavoriteSites();
    currentFavorites.removeWhere((element) => element['url'] == site['url']);
    await _prefs.setString(_favoriteSitesKey, jsonEncode(currentFavorites));
  }

  static Future<void> clearFavoriteSites() async {
    await _prefs.remove(_favoriteSitesKey);
  }
}
