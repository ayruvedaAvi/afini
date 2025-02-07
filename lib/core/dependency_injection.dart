import 'package:get_it/get_it.dart';

import '../data/respository/rem_auth_repo.dart';
import '../domain/repository/auth_repo.dart';

class DependencyInjection {
  static final getIt = GetIt.instance;

  static void init() {
    // Register dependencies
    getIt.registerLazySingleton<AuthRepo>(() => RemAuthRepo());
  }

  static AuthRepo get authRepository => getIt<AuthRepo>();
}
