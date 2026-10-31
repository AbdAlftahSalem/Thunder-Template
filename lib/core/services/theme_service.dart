import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'storage_service.dart';

/// Saves and restores the theme mode (light / dark / system).
class ThemeService {
  static StorageService get _storage => Get.find<StorageService>();

  static ThemeMode get themeMode {
    return switch (_storage.getString(StorageKeys.themeMode)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static Future<void> changeThemeMode(ThemeMode mode) async {
    Get.changeThemeMode(mode);
    await _storage.setString(StorageKeys.themeMode, mode.name);
  }
}
