import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thunder_template/core/services/localization_service.dart';
import 'package:thunder_template/core/services/theme_service.dart';

class SettingsController extends GetxController {
  bool get isDarkMode => Get.isDarkMode;

  String get languageCode => Get.locale?.languageCode ?? 'en';

  Future<void> toggleDarkMode(bool dark) async {
    await ThemeService.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  Future<void> changeLanguage(String languageCode) async {
    await LocalizationService.changeLocale(languageCode);
    update();
  }
}
