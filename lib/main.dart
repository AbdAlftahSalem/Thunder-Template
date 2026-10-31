import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/bindings_app.dart';
import 'core/config/app_config.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/routes.dart';
import 'core/services/localization_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/theme_service.dart';
import 'core/theme/app_theme.dart';
import 'helper/translations/local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeService.themeMode,
      translations: MyLocal(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      initialBinding: BindingApp(),
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    );
  }
}
