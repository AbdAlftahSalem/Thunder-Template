import 'en_translation.dart';
import 'ar_translation.dart';

/// Translations of every language. `thunder localization` adds new languages here.
class MyLocal {
  Map<String, Map<String, String>> get keys => {
        'en': enLanguage,
        'ar': arLanguage,
      };
}
