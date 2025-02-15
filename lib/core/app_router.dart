import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/cubits/auth/auth_cubit.dart';
import '../presentation/screens/auth/code_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/baseLayout/base_layout.dart';
import '../presentation/screens/chats/chats_screen.dart';
import '../presentation/screens/gallery/gallery_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/support/get_started_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/support/splash_screen.dart';
import '../presentation/screens/support/error_screen.dart';
import 'dependency_injection.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Non-authenticated routes (no bottom nav)
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
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
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),

    // Authenticated routes with bottom nav
    GoRoute(
      name: 'code-screen',
      path: '/code-screen/:isCopyCode',
      builder: (context, state) => CodeScreen(
        isCopyCode: state.pathParameters['isCopyCode'] == 'true',
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BaseLayout(
          currentRoute: state.name ?? 'home',
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: 'gallery',
          path: '/gallery',
          builder: (context, state) => const GalleryScreen(),
        ),
        GoRoute(
          name: 'notifications',
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // Modal routes (no bottom nav)
    GoRoute(
      name: 'chats',
      path: '/chats',
      builder: (context, state) => const ChatsScreen(),
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(
    errorMessage: state.error.toString(),
  ),
);
