import 'package:flutter/material.dart';

import 'storage_service.dart';

/// Saves and restores the theme mode (light / dark / system).
class ThemeService {
  static ThemeMode savedThemeMode(StorageService storage) {
    return switch (storage.getString(StorageKeys.themeMode)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  static Future<void> saveThemeMode(
      StorageService storage, ThemeMode mode) async {
    await storage.setString(StorageKeys.themeMode, mode.name);
  }
}
