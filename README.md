# ⚡ Thunder Template — Cubit

A clean **Flutter + Cubit** starter with the same layers in every flavour:
networking, repositories, services, middleware, DI, routing, localization (en/ar), theme and a sample feature.
It is the template used by [Thunder CLI](https://pub.dev/packages/thunder_cli).

Flavours (branches): [GetX](https://github.com/AbdAlftahSalem/Thunder-Template/tree/getx) · [BLoC](https://github.com/AbdAlftahSalem/Thunder-Template/tree/bloc) · [Cubit](https://github.com/AbdAlftahSalem/Thunder-Template/tree/cubit) ← you are here

```bash
dart pub global activate thunder_cli
thunder init my_app --org com.company --state cubit
```

Or click **Use this template** on GitHub (choose *Include all branches* to keep the other flavours) and rename the
package `thunder_template` yourself.

## What's inside

```
lib/
├── main.dart                         MaterialApp.router + SettingsCubit (theme & language)
├── core/
│   ├── di/injection.dart             get_it service locator: sl<HomeRepo>()
│   ├── config/app_config.dart        app name + environment (--dart-define=ENV=prod)
│   ├── middlewares/auth_guard.dart   go_router redirect guard
│   ├── networking/                   DioHelper.safeApiCall → ApiResult, ApiCallStatus, RequestType
│   ├── routing/                      routes.dart + app_router.dart (go_router)
│   ├── services/                     StorageService, ThemeService, LocalizationService
│   └── theme/app_theme.dart          Material 3 light & dark themes
├── helper/
│   ├── constants/                    api_constants.dart, strings_constants.dart
│   ├── translations/                 en + ar, local.dart, `.tr` extension
│   └── widgets/                      CustomText, CustomButton, ApiStateWidget
└── app/
    ├── features/home/                home_view.dart + cubit/home_cubit.dart, home_state.dart
    ├── features/settings/            dark mode + language switch (saved locally)
    ├── repositories/home_repo.dart
    └── models/todo_model.dart
```

Packages: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc), [`get_it`](https://pub.dev/packages/get_it), [`go_router`](https://pub.dev/packages/go_router), [`dio`](https://pub.dev/packages/dio), [`shared_preferences`](https://pub.dev/packages/shared_preferences).

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
| View | `app/features/home/home_view.dart` | UI, `BlocProvider` + `BlocBuilder<HomeCubit, HomeState>` |
| Cubit | `app/features/home/cubit/` | methods → states, calls the repository |
| Repository | `app/repositories/home_repo.dart` | API calls through `DioHelper` |
| Model | `app/models/todo_model.dart` | `fromJson` / `toJson` |
| DI | `core/di/injection.dart` | `sl.registerLazySingleton` / `registerFactory` |
| Route | `core/routing/` | `Routes.HOME` + `GoRoute` |

With Thunder CLI, `thunder feature profile` creates all of these for a new feature.
The `// thunder:` comments mark where Thunder adds new code; keep them.

## License

MIT
