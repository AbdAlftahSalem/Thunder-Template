import 'package:get/get.dart';

import 'en_translation.dart';
import 'ar_translation.dart';

/// GetX translations. `thunder localization` adds new languages here.
class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enLanguage,
        'ar': arLanguage,
      };
}
