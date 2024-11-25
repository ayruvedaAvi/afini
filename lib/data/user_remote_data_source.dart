import 'package:dio/dio.dart';

import '../core/utils/api_handler.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  // Login User
  Future<Map<String, dynamic>> login(String email, String password) async {
    return handleApiCall(() => dio.post('http://localhost:5000/api/auth/login', data: {'email': email, 'password': password}));
  }

  // Signup User
  Future<Map<String, dynamic>> signup(String email, String password) async {
    return handleApiCall(() => dio.post('/signup', data: {'email': email, 'password': password}));
  }

  // Fetch User Profile
  Future<Map<String, dynamic>> fetchUserProfile(String userId) async {
    return handleApiCall(() => dio.get('/users/$userId'));
  }

  // Update User Profile
  Future<Map<String, dynamic>> updateUserProfile(Map<String, dynamic> data) async {
    return handleApiCall(() => dio.put('/users/update', data: data));
  }
}
