import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:thunder_template/core/routing/routes.dart';
import 'package:thunder_template/helper/constants/strings_constants.dart';
import 'package:thunder_template/helper/widgets/api_widgets/api_state_widget.dart';
import 'package:thunder_template/helper/widgets/custom_widgets/custom_text.dart';

import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(txt: StringsConstants.home.tr),
        actions: [
          IconButton(
            tooltip: StringsConstants.settings.tr,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(Routes.SETTINGS),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return ApiStateWidget(
            apiResult: controller.apiResult,
            onRetry: controller.getData,
            child: RefreshIndicator(
              onRefresh: controller.getData,
              child: ListView.separated(
                itemCount: controller.todos.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return ListTile(
                    leading: Icon(
                      todo.completed == true
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                    ),
                    title: CustomText(txt: todo.title ?? '', maxLines: 2),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
