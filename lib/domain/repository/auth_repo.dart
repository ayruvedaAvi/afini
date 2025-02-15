import '../models/user.dart';

abstract class AuthRepo {
  //login and register methods
  Future<User?> login(String email, String password);
  Future<User?> register({required User user});
  Future<void> logout();
}
