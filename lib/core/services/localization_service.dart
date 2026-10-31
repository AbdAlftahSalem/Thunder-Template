import 'dart:ui';

import 'package:thunder_template/helper/translations/tr_extension.dart';

import 'storage_service.dart';

/// Saves and restores the app language.
class LocalizationService {
  static const fallbackLocale = Locale('en');

  /// Languages the app supports (must match `MyLocal.keys`).
  static const supportedLocales = [Locale('en'), Locale('ar')];

  /// The saved language, or the device language when it is supported.
  static Locale savedLocale(StorageService storage) {
    final saved = storage.getString(StorageKeys.languageCode);
    final device = PlatformDispatcher.instance.locale.languageCode;
    final code = saved ??
        (supportedLocales.any((l) => l.languageCode == device)
            ? device
            : fallbackLocale.languageCode);
    AppTranslations.languageCode = code;
    return Locale(code);
  }

  static Future<Locale> changeLocale(
      StorageService storage, String languageCode) async {
    AppTranslations.languageCode = languageCode;
    await storage.setString(StorageKeys.languageCode, languageCode);
    return Locale(languageCode);
  }
}
