import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationHelper with ChangeNotifier {
  final Locale locale;
  Map<String, String>? _localizedStrings;

  LocalizationHelper(this.locale);
  static Future<void> _handleSystemLanguageChange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selected_language');

    Locale systemLocale = window.locale;
    String systemLangCode = systemLocale.languageCode;
    List<String> supportedLanguages = ['en', 'es', 'fr', 'zh-CN', 'gu', 'hi'];

    // If no user-selected language, follow the system
    if (savedLanguage == null) {
      String newLanguage = supportedLanguages.contains(systemLangCode) ? systemLangCode : 'en';
      await saveLanguageCode(newLanguage);
    }
  }


  Future<void> load() async {
    String jsonString = await rootBundle
        .loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static Future<void> saveLanguageCode(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
  }

  static Future<String> getPreferredLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selected_language');

    // Get system language if no language is saved
    Locale systemLocale = window.locale;
    String systemLangCode = systemLocale.languageCode;

    List<String> supportedLanguages = ['en', 'es', 'fr', 'zh-CN', 'gu', 'hi'];

    // If the saved language exists, return it
    if (savedLanguage != null) {
      return savedLanguage;
    }

    // If the system language is supported, return it; otherwise, return English
    return supportedLanguages.contains(systemLangCode) ? systemLangCode : 'en';
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }
}
