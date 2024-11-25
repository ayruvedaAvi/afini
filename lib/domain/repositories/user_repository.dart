import '../../data/user_remote_data_source.dart';

abstract class UserRepository {
  Future<void> login(String email, String password);
  Future<void> signup(String email, String password);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> login(String email, String password) async {
    await remoteDataSource.login(email, password);
  }

  @override
  Future<void> signup(String email, String password) async {
    await remoteDataSource.signup(email, password);
  }
}
