import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../routing/routes.dart';
import '../services/storage_service.dart';

/// Sends users without a saved token to [redirectTo].
///
/// ```dart
/// GetPage(
///   name: Routes.PROFILE,
///   page: () => const ProfileView(),
///   middlewares: [AuthMiddleware(redirectTo: Routes.LOGIN)],
/// )
/// ```
class AuthMiddleware extends GetMiddleware {
  AuthMiddleware({this.redirectTo = Routes.HOME});

  final String redirectTo;

  @override
  RouteSettings? redirect(String? route) {
    final loggedIn = Get.find<StorageService>().token != null;
    return loggedIn ? null : RouteSettings(name: redirectTo);
  }
}
