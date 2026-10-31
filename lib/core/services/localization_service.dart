import 'dart:ui';

import 'package:get/get.dart';

import 'storage_service.dart';

/// Saves and restores the app language.
class LocalizationService {
  static const fallbackLocale = Locale('en');

  /// Languages the app supports (must match `MyLocal.keys`).
  static const supportedLocales = [Locale('en'), Locale('ar')];

  static StorageService get _storage => Get.find<StorageService>();

  /// The saved language, or the device language when it is supported.
  static Locale get locale {
    final saved = _storage.getString(StorageKeys.languageCode);
    if (saved != null) return Locale(saved);
    final device = Get.deviceLocale;
    final supported =
        supportedLocales.any((l) => l.languageCode == device?.languageCode);
    return supported ? Locale(device!.languageCode) : fallbackLocale;
  }

  static Future<void> changeLocale(String languageCode) async {
    await Get.updateLocale(Locale(languageCode));
    await _storage.setString(StorageKeys.languageCode, languageCode);
  }
}
