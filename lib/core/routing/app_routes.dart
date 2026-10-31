import 'package:get/get.dart';

import 'package:thunder_template/app/features/home/home_view.dart';
import 'package:thunder_template/app/features/settings/settings_view.dart';
// thunder:imports
import 'routes.dart';

/// All the pages of the app.
///
/// Protect a page with a middleware:
/// `GetPage(name: ..., page: ..., middlewares: [AuthMiddleware()])`
class AppPages {
  static final routes = [
    GetPage(name: Routes.HOME, page: () => const HomeView()),
    GetPage(name: Routes.SETTINGS, page: () => const SettingsView()),
    // thunder:pages
  ];
}
