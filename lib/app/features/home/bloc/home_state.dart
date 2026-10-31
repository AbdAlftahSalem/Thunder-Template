part of 'home_bloc.dart';

class HomeState {
  final ApiResult apiResult;
  final List<TodoModel> todos;

  const HomeState({required this.apiResult, this.todos = const []});
}
