import 'package:flutter_test/flutter_test.dart';

import 'package:thunder_template/app/models/todo_model.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/enums_networking.dart';

void main() {
  test('ApiResult.handelRequest calls the right callback', () {
    var called = '';
    ApiResult(apiCallStatus: ApiCallStatus.success).handelRequest(
      success: (_) => called = 'success',
      error: (_) => called = 'error',
    );
    expect(called, 'success');

    ApiResult.error(message: 'boom').handelRequest(
      success: (_) => called = 'success',
      error: (_) => called = 'error',
    );
    expect(called, 'error');
  });

  test('TodoModel reads and writes JSON', () {
    final todo = TodoModel.fromJson(
        {'userId': 1, 'id': 2.0, 'title': 'Hi', 'completed': true});
    expect(todo.id, 2);
    expect(todo.toJson(),
        {'userId': 1, 'id': 2, 'title': 'Hi', 'completed': true});
  });
}
