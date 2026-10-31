import 'package:go_router/go_router.dart';

import 'package:thunder_template/app/features/home/home_view.dart';
import 'package:thunder_template/app/features/settings/settings_view.dart';
// thunder:imports
import '../middlewares/auth_guard.dart';
import 'routes.dart';

/// All the pages of the app (go_router).
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.HOME,
    redirect: AuthGuard.redirect,
    routes: [
      GoRoute(path: Routes.HOME, builder: (context, state) => const HomeView()),
      GoRoute(
          path: Routes.SETTINGS,
          builder: (context, state) => const SettingsView()),
      // thunder:pages
    ],
  );
}
