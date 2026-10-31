import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:thunder_template/app/features/home/home_controller.dart';
import 'package:thunder_template/app/features/home/home_view.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/base_client.dart';

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
  tearDown(Get.reset);

  testWidgets('HomeView shows the todos from the repository', (tester) async {
    Get.put(HomeController(homeRepo: FakeHomeRepo()));

    await tester.pumpWidget(const GetMaterialApp(home: HomeView()));
    await tester.pumpAndSettle();

    expect(find.text('Write tests'), findsOneWidget);
    expect(find.text('Ship the app'), findsOneWidget);
  });
}
