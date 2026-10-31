import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thunder_template/core/services/localization_service.dart';
import 'package:thunder_template/core/services/storage_service.dart';
import 'package:thunder_template/core/services/theme_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

/// App settings (theme + language), saved in local storage.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final StorageService storage;

  SettingsBloc({required this.storage})
      : super(SettingsState(
          themeMode: ThemeService.savedThemeMode(storage),
          locale: LocalizationService.savedLocale(storage),
        )) {
    on<SettingsThemeChanged>((event, emit) async {
      await ThemeService.saveThemeMode(storage, event.themeMode);
      emit(state.copyWith(themeMode: event.themeMode));
    });
    on<SettingsLanguageChanged>((event, emit) async {
      final locale =
          await LocalizationService.changeLocale(storage, event.languageCode);
      emit(state.copyWith(locale: locale));
    });
  }
}
