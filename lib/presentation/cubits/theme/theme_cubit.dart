import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/theme_settings.dart';
import '../../../domain/repository/theme_repo.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepo _repository;
  StreamSubscription? _themeSubscription;

  ThemeCubit(this._repository)
      : super(ThemeState(
          themeMode: MyThemeMode.system,
          accentColor: Colors.purple,
          fontSize: 14,
          chatBackground: null,
          isLoading: true,
        )) {
    _init();
  }

  Future<void> _init() async {
    try {
      _themeSubscription =
          _repository.observeThemeSettings().listen((settings) {
        emit(state.copyWith(
          themeMode: settings.themeMode,
          accentColor: settings.accentColor,
          fontSize: settings.fontSize,
          chatBackground: settings.chatBackground,
          isLoading: false,
        ));
      }, onError: (error) {
        emit(state.copyWith(
          errorMessage: 'Failed to load theme settings',
          isLoading: false,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to initialize theme settings',
        isLoading: false,
      ));
    }
  }

  Future<void> setThemeMode(MyThemeMode mode) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.saveThemeSettings(
        ThemeSettings(
          themeMode: mode,
          accentColor: state.accentColor,
          fontSize: state.fontSize,
          chatBackground: state.chatBackground,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to save theme mode',
        isLoading: false,
      ));
    }
  }

  Future<void> setAccentColor(Color color) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.saveThemeSettings(
        ThemeSettings(
          themeMode: state.themeMode,
          accentColor: color,
          fontSize: state.fontSize,
          chatBackground: state.chatBackground,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to save accent color',
        isLoading: false,
      ));
    }
  }

  Future<void> setFontSize(double size) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.saveThemeSettings(
        ThemeSettings(
          themeMode: state.themeMode,
          accentColor: state.accentColor,
          fontSize: size,
          chatBackground: state.chatBackground,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to save font size',
        isLoading: false,
      ));
    }
  }

  Future<void> setChatBackground(String? backgroundPath) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.saveThemeSettings(
        ThemeSettings(
          themeMode: state.themeMode,
          accentColor: state.accentColor,
          fontSize: state.fontSize,
          chatBackground: backgroundPath,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to save chat background',
        isLoading: false,
      ));
    }
  }

  void resetError() {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _themeSubscription?.cancel();
    return super.close();
  }
}
