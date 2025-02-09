import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/cubits/auth/auth_cubit.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/support/get_started_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/support/splash_screen.dart';
import '../presentation/screens/support/error_screen.dart';
import 'dependency_injection.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'get-started',
      path: '/get-started',
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(DependencyInjection.authRepository),
        child: const LoginScreen()),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(
    errorMessage: state.error.toString(),
  ),
);
