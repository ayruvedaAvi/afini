import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return error.response?.data['message'] ?? 'Something went wrong';
      } else {
        return 'Network error: ${error.message}';
      }
    }
    return 'Unexpected error: $error';
  }
}
