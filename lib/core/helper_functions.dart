import 'package:dio/dio.dart';


// helper function to handle exceptions
String handleException(DioException dioError) {
  if (dioError.response != null) {
    try {
      final message = dioError.response?.data['message'];
      if (message is String && message.isNotEmpty) {
        return message; 
      }
    } catch (_) {
      // Ignore errors while extracting message
    }
  }

  switch (dioError.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout. Please try again.';
    case DioExceptionType.sendTimeout:
      return 'Send timeout. Please try again.';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout. Please try again.';
    case DioExceptionType.badResponse:
      return 'Server responded with an error. Please try again later.';
    case DioExceptionType.cancel:
      return 'Request was cancelled.';
    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network.';
    default:
      return 'Something went wrong. Please try again.';
  }
}