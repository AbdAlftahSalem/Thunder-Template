import 'package:get/get.dart';

import '../networking/base_client.dart';
import 'package:thunder_template/app/features/home/home_controller.dart';
import 'package:thunder_template/app/features/settings/settings_controller.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
// thunder:imports

/// App-wide dependency injection. `thunder feature` and `thunder c_api`
/// register new repositories and controllers here.
class BindingApp extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DioHelper(), fenix: true);
    Get.lazyPut(() => HomeRepo(Get.find<DioHelper>()), fenix: true);
    Get.lazyPut(() => HomeController(homeRepo: Get.find<HomeRepo>()),
        fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    // thunder:bindings
  }
}
