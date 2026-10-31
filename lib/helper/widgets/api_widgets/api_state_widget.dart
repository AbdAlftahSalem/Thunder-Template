import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/networking/api_result.dart';
import '../../../core/networking/enums_networking.dart';
import '../../constants/strings_constants.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text.dart';

/// Shows loading / error / empty states for an [ApiResult] and [child] when
/// the data is ready.
class ApiStateWidget extends StatelessWidget {
  const ApiStateWidget({
    super.key,
    required this.apiResult,
    required this.child,
    this.onRetry,
  });

  final ApiResult apiResult;
  final Widget child;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (apiResult.apiCallStatus) {
      ApiCallStatus.holding ||
      ApiCallStatus.loading =>
        const Center(child: CircularProgressIndicator()),
      ApiCallStatus.error => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  txt: apiResult.message ??
                      StringsConstants.somethingWentWrong.tr,
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 16),
                  CustomButton(
                      text: StringsConstants.retry.tr, onPressed: onRetry),
                ],
              ],
            ),
          ),
        ),
      ApiCallStatus.empty =>
        Center(child: CustomText(txt: StringsConstants.noData.tr)),
      ApiCallStatus.success => child,
    };
  }
}
