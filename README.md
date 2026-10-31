# ⚡ Thunder Template — GetX

A clean **Flutter + GetX** starter with the same layers in every flavour:
networking, repositories, services, middleware, DI, routing, localization (en/ar), theme and a sample feature.
It is the template used by [Thunder CLI](https://pub.dev/packages/thunder_cli).

Flavours (branches): [GetX](https://github.com/AbdAlftahSalem/Thunder-Template/tree/getx) ← you are here · [BLoC](https://github.com/AbdAlftahSalem/Thunder-Template/tree/bloc) · [Cubit](https://github.com/AbdAlftahSalem/Thunder-Template/tree/cubit)

```bash
dart pub global activate thunder_cli
thunder init my_app --org com.company --state getx
```

Or click **Use this template** on GitHub (choose *Include all branches* to keep the other flavours) and rename the
package `thunder_template` yourself.

## What's inside

```
lib/
├── main.dart                         GetMaterialApp: routes, bindings, theme, translations
├── core/
│   ├── bindings/bindings_app.dart    dependency injection (Get.lazyPut)
│   ├── config/app_config.dart        app name + environment (--dart-define=ENV=prod)
│   ├── middlewares/auth_middleware.dart  GetMiddleware route guard
│   ├── networking/                   DioHelper.safeApiCall → ApiResult, ApiCallStatus, RequestType
│   ├── routing/                      routes.dart + app_routes.dart (GetPage list)
│   ├── services/                     StorageService, ThemeService, LocalizationService
│   └── theme/app_theme.dart          Material 3 light & dark themes
├── helper/
│   ├── constants/                    api_constants.dart, strings_constants.dart
│   ├── translations/                 en + ar, local.dart (GetX Translations)
│   └── widgets/                      CustomText, CustomButton, ApiStateWidget
└── app/
    ├── features/home/                home_view.dart + home_controller.dart (list from an API)
    ├── features/settings/            dark mode + language switch (saved locally)
    ├── repositories/home_repo.dart
    └── models/todo_model.dart
```

Packages: [`get`](https://pub.dev/packages/get), [`dio`](https://pub.dev/packages/dio), [`shared_preferences`](https://pub.dev/packages/shared_preferences).

## Run

```bash
flutter pub get
flutter run
flutter run --dart-define=ENV=prod --dart-define=BASE_URL=https://api.example.com/
flutter test
```

## How a feature is built

| Layer | File | Job |
| --- | --- | --- |
| View | `app/features/home/home_view.dart` | UI, `GetBuilder<HomeController>` |
| Controller | `app/features/home/home_controller.dart` | state + calls the repository |
| Repository | `app/repositories/home_repo.dart` | API calls through `DioHelper` |
| Model | `app/models/todo_model.dart` | `fromJson` / `toJson` |
| DI | `core/bindings/bindings_app.dart` | `Get.lazyPut` for repo + controller |
| Route | `core/routing/` | `Routes.HOME` + `GetPage` |

With Thunder CLI, `thunder feature profile` creates all of these for a new feature.
The `// thunder:` comments mark where Thunder adds new code; keep them.

## License

MIT
