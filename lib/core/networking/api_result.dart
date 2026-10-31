import 'enums_networking.dart';

/// Result of every API call made through `DioHelper.safeApiCall`.
class ApiResult<T> {
  T? data;
  String? message;
  int? statusCode;
  ApiCallStatus apiCallStatus;

  ApiResult({
    this.data,
    this.message,
    this.statusCode,
    this.apiCallStatus = ApiCallStatus.holding,
  });

  factory ApiResult.success({T? data, int? statusCode}) => ApiResult(
        data: data,
        statusCode: statusCode,
        apiCallStatus: ApiCallStatus.success,
      );

  factory ApiResult.error({
    String? message,
    int? statusCode,
    ApiCallStatus apiCallStatus = ApiCallStatus.error,
  }) =>
      ApiResult(
        message: message,
        statusCode: statusCode,
        apiCallStatus: apiCallStatus,
      );

  bool get isLoading => apiCallStatus == ApiCallStatus.loading;

  bool get isSuccess =>
      apiCallStatus == ApiCallStatus.success ||
      apiCallStatus == ApiCallStatus.empty;

  bool get isError => apiCallStatus == ApiCallStatus.error;

  /// Calls [success] or [error] depending on the result.
  void handelRequest({
    required void Function(ApiResult<T> result) success,
    required void Function(ApiResult<T> result) error,
  }) {
    if (isSuccess) {
      success(this);
    } else if (isError) {
      error(this);
    }
  }

  /// Same as [handelRequest].
  void handleRequest({
    required void Function(ApiResult<T> result) success,
    required void Function(ApiResult<T> result) error,
  }) =>
      handelRequest(success: success, error: error);
}
