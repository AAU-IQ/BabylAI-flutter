import 'package:dio/dio.dart';
import '../../../../babylai.dart';
import '../../sharedpref/SharedPreferenceHelper.dart';

class ErrorInterceptor extends Interceptor {
  final SharedPreferenceHelper _sharedPreferenceHelper;

  ErrorInterceptor(this._sharedPreferenceHelper);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('onError: ${err.response?.statusCode}');

    // Check if error is due to token expiration (401 or 403)
    if (err.response != null &&
        (err.response!.statusCode == 401 || err.response!.statusCode == 403)) {
      try {
        // Get a fresh token
        final token = await BabylAI.getToken();

        if (token != null && token.isNotEmpty) {
          // Save the new token
          _sharedPreferenceHelper.saveAuthToken(token);

          // Create a new Dio instance for the retry
          // This avoids circular dependency issues
          final retryDio = Dio();

          // Copy the base options from the original request
          retryDio.options.baseUrl = err.requestOptions.baseUrl;
          retryDio.options.connectTimeout = err.requestOptions.connectTimeout;
          retryDio.options.receiveTimeout = err.requestOptions.receiveTimeout;
          retryDio.options.sendTimeout = err.requestOptions.sendTimeout;

          // Clone the original request
          final options = Options(
            method: err.requestOptions.method,
            headers: {
              ...err.requestOptions.headers,
              'Authorization':
                  'Bearer $token', // Update Authorization header with new token
            },
          );

          // Retry the original request with the new token
          final response = await retryDio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: options,
          );

          // If retry is successful, return the response
          return handler.resolve(response);
        } else {}
      } catch (e) {
        throw Exception('Error during token refresh and retry: $e');
      }
    }

    // If we couldn't handle the error, continue with the error
    return super.onError(err, handler);
  }
}
