import 'package:dio/dio.dart';

import 'api_urls.dart';
import 'app_router.dart';
import 'token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await TokenStorage.getAccessToken();
    if (token != null) {
      options.headers['x-auth-token'] = token;
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      bool success = await _refreshToken();
      if (success) {
        var retryRequest = await _retry(err.requestOptions);
        handler.resolve(retryRequest);
      } else {
        await _handleLogout();
        handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> _refreshToken() async {
    String? refreshToken = await TokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      Response response = await dio
          .post(ApiUrls.REFRESH, data: {'refresh_token': refreshToken});
      if (response.statusCode == 200) {
        String newAccessToken = response.data['access_token'];
        String newRefreshToken = response.data['refresh_token'];
        await TokenStorage.saveTokens(newAccessToken, newRefreshToken);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    String? newAccessToken = await TokenStorage.getAccessToken();
    requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    return dio.fetch(requestOptions);
  }

  Future<void> _handleLogout() async {
    await TokenStorage.clearTokens();
    appRouter.goNamed('login');
  }
}
