import 'package:get/get.dart';

import 'package:thunder_template/app/models/todo_model.dart';
import 'package:thunder_template/app/repositories/home_repo.dart';
import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/enums_networking.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  ApiResult apiResult = ApiResult();
  List<TodoModel> todos = [];

  /// Loads the data of this feature from the API.
  Future<void> getData() async {
    apiResult = ApiResult(apiCallStatus: ApiCallStatus.loading);
    update();

    apiResult = await homeRepo.getHomeData();
    apiResult.handelRequest(
      success: (result) {
        todos = (result.data as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(TodoModel.fromJson)
            .toList();
      },
      error: (result) {},
    );

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
