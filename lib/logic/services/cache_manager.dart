import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tepmare_warehouse_man_app/main.dart';

import '../../config/constants.dart';

class CacheManager {
  static Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox(CacheManager.kBoxName);
    await Hive.openBox(CacheManager.kBoxImagesName);
    String? lang = getLanguageCode();
    localLanguage = lang ?? "fr";
    globalKey.currentContext!.setLocale(Locale(lang ?? "fr"));
  }

  static const String kBoxName = 'tepmare';
  static const String kBoxImagesName = 'tepmare_cached_images';

  static const String _kUserToken = "user_token";
  static const String _kUsername = "username";

  static const String _kLanguageCode = "language";
  static const String _kRecentLocationsSearch = "recentLocationsSearch";

  static final Box _prefs = Hive.box(kBoxName);
  static final Box _imagesPrefs = Hive.box(kBoxImagesName);

  static String? getLanguageCode() {
    return _prefs.get(_kLanguageCode);
  }

  static void setLanguageCode(String? value) {
    _prefs.put(_kLanguageCode, value);
  }

  static String? getUserToken() {
    return _prefs.get(_kUserToken);
  }

  static void setUserToken(String? value) {
    _prefs.put(_kUserToken, value);
  }

  static String? getUsername() {
    return _prefs.get(_kUsername);
  }

  static void setUsername(String? value) {
    _prefs.put(_kUsername, value);
  }

  static List<dynamic> getRecentLocationsSearch() {
    return _prefs.get(_kRecentLocationsSearch) ?? [];
  }

  static void setRecentLocationsSearch(List<dynamic> recentLocations) {
    _prefs.put(_kRecentLocationsSearch, recentLocations ?? []);
  }

  static String getCachedImage(String url) {
    return _imagesPrefs.get(url) ?? '';
  }

  static void setCachedImage(String url, String? base64) {
    _imagesPrefs.put(url, base64);
  }
}
