import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../routing/routes.dart';
import '../services/storage_service.dart';

/// Route guard (middleware): users without a saved token can not open the
/// routes in [protectedRoutes] and are sent to [redirectTo].
class AuthGuard {
  /// Add routes that need a logged in user, ex: `Routes.PROFILE`.
  static const List<String> protectedRoutes = [];

  static const String redirectTo = Routes.HOME;

  static String? redirect(BuildContext context, GoRouterState state) {
    final loggedIn = sl<StorageService>().token != null;
    if (!loggedIn && protectedRoutes.contains(state.matchedLocation)) {
      return redirectTo;
    }
    return null;
  }
}
