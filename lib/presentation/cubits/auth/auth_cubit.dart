import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';

class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});
}

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit(this.userRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    emit(AuthState(isLoading: true));
    try {
      await userRepository.login(email, password);
      emit(AuthState()); // Success
    } catch (e) {
      emit(AuthState(error: e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(AuthState(isLoading: true));
    try {
      await userRepository.signup(email, password);
      emit(AuthState()); // Success
    } catch (e) {
      emit(AuthState(error: e.toString()));
    }
  }
}
