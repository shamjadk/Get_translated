import 'package:shared_preferences/shared_preferences.dart';

class StoreLang {
  static Future<void> storeFromLang(String fromLang) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('from_lang', fromLang);
  }

  static Future<void> storeFromLangCode(String fromLangCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('from_lang_code', fromLangCode);
  }

  static Future<void> storeToLang(String toLang) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('to_lang', toLang);
  }

  static Future<void> storeToLangCode(String toLangCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('to_lang_code', toLangCode);
  }

  static Future<String?> getFromLangSP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('from_lang') ?? 'English';
  }

  static Future<String?> getFromLangCodeSP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('from_lang_code') ?? 'en';
  }

  static Future<String?> getToLangSP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('to_lang') ?? 'English';
  }

  static Future<String?> getToLangCodeSP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('to_lang_code') ?? 'hi';
  }
}
