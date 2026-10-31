import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../helper/constants/api_constants.dart';
import '../di/injection.dart';
import '../services/storage_service.dart';
import 'api_result.dart';
import 'enums_networking.dart';

/// Thin wrapper around [Dio]. Every request returns an [ApiResult] and never
/// throws, so controllers only have to check `apiResult.apiCallStatus`.
class DioHelper {
  DioHelper({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Send the saved token with every request.
          if (sl.isRegistered<StorageService>()) {
            final token = sl<StorageService>().token;
            if (token != null &&
                !options.headers.containsKey('Authorization')) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          handler.next(options);
        },
      ),
    );
    if (kDebugMode) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  final Dio _dio;

  /// The underlying Dio instance (add interceptors here).
  Dio get dio => _dio;

  /// Performs a request and wraps the response (or the error) in an [ApiResult].
  Future<ApiResult> safeApiCall(
    String url,
    RequestType requestType, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: requestType.name.toUpperCase(),
          headers: headers,
        ),
      );
      final body = response.data;
      final isEmpty = body == null ||
          (body is List && body.isEmpty) ||
          (body is Map && body.isEmpty);
      return ApiResult(
        data: body,
        statusCode: response.statusCode,
        apiCallStatus: isEmpty ? ApiCallStatus.empty : ApiCallStatus.success,
      );
    } on DioException catch (e) {
      return ApiResult.error(
        message: _errorMessage(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResult.error(message: e.toString());
    }
  }

  String _errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return e.message ?? 'Something went wrong';
    }
  }
}
