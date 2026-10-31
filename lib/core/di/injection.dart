import 'package:get_it/get_it.dart';

import '../networking/base_client.dart';
import '../services/storage_service.dart';
import 'package:thunder_template/app/features/home/bloc/home_bloc.dart';
import 'package:thunder_template/app/features/settings/bloc/settings_bloc.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
// thunder:imports

/// Service locator. Use `sl<HomeRepo>()` anywhere.
final GetIt sl = GetIt.instance;

/// Registers every dependency. `thunder feature` and `thunder c_api` add new
/// repositories and blocs here.
Future<void> setupDependencies() async {
  sl.registerSingleton<StorageService>(await StorageService().init());
  sl.registerLazySingleton(() => DioHelper());
  sl.registerLazySingleton(() => HomeRepo(sl()));
  sl.registerFactory(() => HomeBloc(homeRepo: sl()));
  sl.registerLazySingleton(() => SettingsBloc(storage: sl()));
  // thunder:di
}
