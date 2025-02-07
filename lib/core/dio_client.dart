import 'package:dio/dio.dart';

import 'api_urls.dart';

class DioClient {
  // Private constructor
  DioClient._();

  // Singleton instance
  static DioClient? _instance;

  // Dio instance
  static Dio? _dio;

  // Base URL for API
  static const String _baseUrl = ApiUrls.BASE_URL;

  // Get DioClient instance
  static DioClient get instance {
    _instance ??= DioClient._();
    return _instance!;
  }

  // Get Dio instance
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  // Create and configure Dio instance
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      LogInterceptor(
        requestBody: false,
        responseBody: true,
      ),
      // Add other interceptors here (auth, retry, etc.)
    ]);

    return dio;
  }

  // Method to reset dio instance (useful for testing or updating configurations)
  void reset() {
    _dio?.close();
    _dio = null;
  }
}
