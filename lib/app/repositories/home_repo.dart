import 'package:thunder_template/core/networking/api_result.dart';
import 'package:thunder_template/core/networking/base_client.dart';
import 'package:thunder_template/core/networking/enums_networking.dart';
import 'package:thunder_template/helper/constants/api_constants.dart';

class HomeRepo {
  final DioHelper dioHelper;

  HomeRepo(this.dioHelper);

  Future<ApiResult> getHomeData({Map<String, dynamic>? queryParameters}) {
    return dioHelper.safeApiCall(
      ApiConstants.home,
      RequestType.get,
      queryParameters: queryParameters ?? {'_limit': 20},
    );
  }
}
