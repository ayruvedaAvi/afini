import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(const AuthState());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
      ));

      final user = await _authRepo.login(email, password);
      
      if (user != null) {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'Login failed: User not found',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> register(String email, String password) async {
    try {
      emit(state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
      ));

      final user = await _authRepo.register(email, password);
      
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      
      await _authRepo.logout();
      
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetError() {
    emit(state.copyWith(
      errorMessage: null,
      status: state.user != null 
          ? AuthStatus.authenticated 
          : AuthStatus.unauthenticated,
    ));
  }
}