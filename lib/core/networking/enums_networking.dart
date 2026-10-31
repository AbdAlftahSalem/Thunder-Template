/// State of an API call, used by views to show loading / error / data.
enum ApiCallStatus { holding, loading, success, empty, error }

/// HTTP methods supported by [DioHelper.safeApiCall].
enum RequestType { get, post, put, patch, delete }
