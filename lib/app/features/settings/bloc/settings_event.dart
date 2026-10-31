part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;

  SettingsThemeChanged(this.themeMode);
}

final class SettingsLanguageChanged extends SettingsEvent {
  final String languageCode;

  SettingsLanguageChanged(this.languageCode);
}
