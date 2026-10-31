/// App-wide configuration.
///
/// Values can be changed per build with `--dart-define`:
/// `flutter run --dart-define=ENV=prod --dart-define=BASE_URL=https://api.example.com/`
class AppConfig {
  static const String appName = 'Thunder Template';

  /// `dev`, `staging` or `prod`.
  static const String environment =
      String.fromEnvironment('ENV', defaultValue: 'dev');

  static bool get isProduction => environment == 'prod';
}
