import '../../domain/models/user.dart';
import '../../domain/repository/auth_repo.dart';

class RemAuthRepo implements AuthRepo{

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      email: email,
      fullName: 'John Doe',
      userName: 'johndoe',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
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