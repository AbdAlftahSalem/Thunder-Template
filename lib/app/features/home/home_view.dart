import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:thunder_template/core/di/injection.dart';
import 'package:thunder_template/core/routing/routes.dart';
import 'package:thunder_template/helper/constants/strings_constants.dart';
import 'package:thunder_template/helper/translations/tr_extension.dart';
import 'package:thunder_template/helper/widgets/api_widgets/api_state_widget.dart';
import 'package:thunder_template/helper/widgets/custom_widgets/custom_text.dart';

import 'cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..getData(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(txt: StringsConstants.home.tr),
          actions: [
            IconButton(
              tooltip: StringsConstants.settings.tr,
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push(Routes.SETTINGS),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return ApiStateWidget(
              apiResult: state.apiResult,
              onRetry: () => context.read<HomeCubit>().getData(),
              child: RefreshIndicator(
                onRefresh: () async => context.read<HomeCubit>().getData(),
                child: ListView.separated(
                  itemCount: state.todos.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
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
      ),
    );
  }
}
