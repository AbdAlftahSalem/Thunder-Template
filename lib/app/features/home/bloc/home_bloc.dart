import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thunder_template/app/models/todo_model.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/enums_networking.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo homeRepo;

  HomeBloc({required this.homeRepo})
      : super(HomeState(apiResult: ApiResult())) {
    on<HomeStarted>(_onStarted);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
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
