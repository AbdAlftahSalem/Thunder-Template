import 'package:flutter/widgets.dart';

import 'local.dart';

/// Current language used by [TranslateString.tr].
class AppTranslations {
  static String languageCode = 'en';

  static final Map<String, Map<String, String>> _keys = MyLocal().keys;

  /// Rebuilds every widget under [context] so `.tr` texts use the new language.
  static void refreshApp(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static String translate(String key) =>
      _keys[languageCode]?[key] ?? _keys['en']?[key] ?? key;
}

/// `Text(StringsConstants.home.tr)` shows the text in the current language.
extension TranslateString on String {
  String get tr => AppTranslations.translate(this);
}
