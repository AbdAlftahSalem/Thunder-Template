import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thunder_template/app/models/todo_model.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/enums_networking.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo})
      : super(HomeState(apiResult: ApiResult()));

  /// Loads (or reloads) the data of the page.
  Future<void> getData() async {
    emit(HomeState(
      apiResult: ApiResult(apiCallStatus: ApiCallStatus.loading),
      todos: state.todos,
    ));

    final result = await homeRepo.getHomeData();
    var todos = state.todos;
    result.handelRequest(
      success: (result) {
        todos = (result.data as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(TodoModel.fromJson)
            .toList();
      },
      error: (result) {},
    );

    emit(HomeState(apiResult: result, todos: todos));
  }
}
