
import 'package:dio/dio.dart';
import 'api_error_handler.dart';

Future<Map<String, dynamic>> handleApiCall(Future<Response> Function() apiCall) async {
  try {
    final response = await apiCall();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  } on DioException catch (e) {
    throw Exception(ApiErrorHandler.handleError(e));
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
