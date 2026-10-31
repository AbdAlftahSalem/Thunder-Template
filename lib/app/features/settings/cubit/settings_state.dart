part of 'settings_cubit.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsState({required this.themeMode, required this.locale});

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale}) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
      );
}
