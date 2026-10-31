import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/features/settings/bloc/settings_bloc.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/services/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'helper/translations/tr_extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsBloc>(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        // Texts use `.tr`: rebuild every page when the language changes.
        listenWhen: (previous, current) => previous.locale != current.locale,
        listener: (context, _) => AppTranslations.refreshApp(context),
        builder: (context, settings) {
          return MaterialApp.router(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: settings.locale,
            supportedLocales: LocalizationService.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
