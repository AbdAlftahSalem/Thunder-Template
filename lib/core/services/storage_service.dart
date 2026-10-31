import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys saved in local storage.
abstract class StorageKeys {
  static const token = 'token';
  static const themeMode = 'theme_mode';
  static const languageCode = 'language_code';
}

/// Local key-value storage (SharedPreferences). Registered in `main()`
/// before the app starts, so it is always available with `Get.find`.
class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  Future<bool> remove(String key) => _prefs.remove(key);

  String? get token => getString(StorageKeys.token);

  Future<void> saveToken(String? token) async {
    if (token == null) {
      await remove(StorageKeys.token);
    } else {
      await setString(StorageKeys.token, token);
    }
  }
}
