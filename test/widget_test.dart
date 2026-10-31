import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thunder_template/app/features/home/cubit/home_cubit.dart';
import 'package:thunder_template/app/features/home/home_view.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
import 'package:thunder_template/core/di/injection.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/base_client.dart';
import 'package:thunder_template/main.dart';

class FakeHomeRepo extends HomeRepo {
  FakeHomeRepo() : super(DioHelper());

  @override
  Future<ApiResult> getHomeData({Map<String, dynamic>? queryParameters}) async {
    return ApiResult.success(data: [
      {'id': 1, 'title': 'Write tests', 'completed': true},
      {'id': 2, 'title': 'Ship the app', 'completed': false},
    ]);
  }
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'language_code': 'en'});
    await sl.reset();
    await setupDependencies();
    sl.unregister<HomeCubit>();
    sl.registerFactory(() => HomeCubit(homeRepo: FakeHomeRepo()));
  });

  testWidgets('HomeView shows the todos from the repository', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));
    await tester.pumpAndSettle();

    expect(find.text('Write tests'), findsOneWidget);
    expect(find.text('Ship the app'), findsOneWidget);
  });

  testWidgets('the app starts and switches language from settings',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ع'));
    await tester.pumpAndSettle();

    expect(find.text('الإعدادات'), findsOneWidget);
  });
}
