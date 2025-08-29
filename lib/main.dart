import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import 'core/app_router.dart';
import 'core/dependency_injection.dart';
import 'domain/models/theme_settings.dart';
import 'domain/services/theme_service.dart';
import 'presentation/cubits/theme/theme_cubit.dart';
import 'presentation/cubits/theme/theme_state.dart';
import 'presentation/widgets/custom_snack_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  unawaited(RiveFile.initialize());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ThemeCubit(DependencyInjection.themeRepository)),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ThemeCubit, ThemeState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                CustomSnackBar.show(
                  context: context,
                  message: state.errorMessage!,
                  type: SnackBarType.error,
                );
                context.read<ThemeCubit>().resetError();
              }
            },
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeService.getLightTheme(state.accentColor),
            darkTheme: ThemeService.getDarkTheme(state.accentColor),
            themeMode: state.themeMode == MyThemeMode.system
                ? ThemeMode.system
                : state.themeMode == MyThemeMode.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            routerConfig: appRouter,
          );
        }),
      ),
    );
  }
}
