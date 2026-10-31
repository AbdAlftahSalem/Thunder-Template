import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thunder_template/core/services/localization_service.dart';
import 'package:thunder_template/core/services/storage_service.dart';
import 'package:thunder_template/core/services/theme_service.dart';

part 'settings_state.dart';

/// App settings (theme + language), saved in local storage.
class SettingsCubit extends Cubit<SettingsState> {
  final StorageService storage;

  SettingsCubit({required this.storage})
      : super(SettingsState(
          themeMode: ThemeService.savedThemeMode(storage),
          locale: LocalizationService.savedLocale(storage),
        ));

  Future<void> changeTheme(ThemeMode themeMode) async {
    await ThemeService.saveThemeMode(storage, themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> changeLanguage(String languageCode) async {
    final locale =
        await LocalizationService.changeLocale(storage, languageCode);
    emit(state.copyWith(locale: locale));
  }
}
