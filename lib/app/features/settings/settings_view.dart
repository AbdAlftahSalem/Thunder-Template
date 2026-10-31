import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thunder_template/helper/constants/strings_constants.dart';
import 'package:thunder_template/helper/translations/tr_extension.dart';
import 'package:thunder_template/helper/widgets/custom_widgets/custom_text.dart';

import 'bloc/settings_bloc.dart';

/// Uses the app-wide SettingsBloc provided in `main.dart`.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(txt: StringsConstants.settings.tr)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final dark = state.themeMode == ThemeMode.dark ||
              (state.themeMode == ThemeMode.system &&
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark);
          return ListView(
            children: [
              SwitchListTile(
                title: CustomText(txt: StringsConstants.darkMode.tr),
                value: dark,
                onChanged: (dark) => context.read<SettingsBloc>().add(
                    SettingsThemeChanged(
                        dark ? ThemeMode.dark : ThemeMode.light)),
              ),
              ListTile(
                title: CustomText(txt: StringsConstants.language.tr),
                trailing: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'en', label: Text('EN')),
                    ButtonSegment(value: 'ar', label: Text('ع')),
                  ],
                  selected: {state.locale.languageCode},
                  onSelectionChanged: (value) => context
                      .read<SettingsBloc>()
                      .add(SettingsLanguageChanged(value.first)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
