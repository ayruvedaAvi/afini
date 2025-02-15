import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../core/api_urls.dart';
import '../../core/dio_client.dart';
import '../../core/helper_functions.dart';
import '../../core/token_storage.dart';
import '../../domain/models/user.dart';
import '../../domain/repository/auth_repo.dart';
import '../models/rem_user.dart';

class RemAuthRepo implements AuthRepo {
  final dio = DioClient.instance.dio;
  late Response response;
  @override
  Future<User?> login(String email, String password) async {
    User? userResponse;
    try {
      response = await dio.post(
        ApiUrls.LOGIN,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        RemUser user = RemUser.fromJson(response.data);
        debugPrint('User: ${user.full_name}');
        userResponse = User(
          id: user.id,
          email: user.email ?? '',
          fullName: user.full_name ?? '',
          userName: user.user_name ?? '',
        );
      } else {
        throw response.data['message'] ??
            'An unexpected error occurred. Please try again later';
      }
    } on DioException catch (dioError) {
      throw handleException(dioError);
    } catch (e) {
      debugPrint('Error: $e');
      throw 'An unexpected error occurred. Please try again later';
    }
    return userResponse;
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();
      final response =
          await dio.post(ApiUrls.LOGOUT, data: {'refresh_token': refreshToken});
      if (response.statusCode == 200) {
        await TokenStorage.clearTokens();
      }
    } on DioException catch (dioError) {
      throw handleException(dioError);
    } catch (e) {
      debugPrint('Error: $e');
      throw 'An unexpected error occurred. Please try again later';
    }
  }

  @override
  Future<User> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      email: email,
      fullName: 'John Doe',
      userName: 'johndoe',
    );
  }
}
