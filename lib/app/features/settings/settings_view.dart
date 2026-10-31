import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thunder_template/helper/constants/strings_constants.dart';
import 'package:thunder_template/helper/widgets/custom_widgets/custom_text.dart';

import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(txt: StringsConstants.settings.tr)),
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return ListView(
            children: [
              SwitchListTile(
                title: CustomText(txt: StringsConstants.darkMode.tr),
                value: controller.isDarkMode,
                onChanged: controller.toggleDarkMode,
              ),
              ListTile(
                title: CustomText(txt: StringsConstants.language.tr),
                trailing: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'en', label: Text('EN')),
                    ButtonSegment(value: 'ar', label: Text('ع')),
                  ],
                  selected: {controller.languageCode},
                  onSelectionChanged: (value) =>
                      controller.changeLanguage(value.first),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
