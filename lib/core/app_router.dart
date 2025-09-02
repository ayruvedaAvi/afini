import 'package:affini/presentation/screens/baseLayout/bucket_list/bucket_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/cubits/auth/auth_cubit.dart';
import '../presentation/screens/auth/code_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/baseLayout/base_layout.dart';
import '../presentation/screens/chats/chat_theme_settings.dart';
import '../presentation/screens/chats/chats_screen.dart';
import '../presentation/screens/baseLayout/gallery/gallery_screen.dart';
import '../presentation/screens/notifications/notifications_screen.dart';
import '../presentation/screens/baseLayout/profile/profile_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/settings/theme_settings._screen.dart';
import '../presentation/screens/support/get_started_screen.dart';
import '../presentation/screens/baseLayout/home/home_screen.dart';
import '../presentation/screens/support/splash_screen.dart';
import '../presentation/screens/support/error_screen.dart';
import 'dependency_injection.dart';

enum AppRoutes {
  splash('/splash'),
  getStarted('/get-started'),
  login('/login'),
  signup('/signup'),
  codeScreen('/code-screen/:isCopyCode'),
  home('/home'),
  gallery('/gallery'),
  bucketList('/bucket-list'),
  notifications('/notifications'),
  profile('/profile'),
  chats('/chats'),
  settings('/settings'),
  themeSettings('/settings/theme'),
  chatTheme('/chats/theme');

  const AppRoutes(this.path);
  final String path;
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash.path,
  routes: [
    // Non-authenticated routes (no bottom nav)
    GoRoute(
      name: AppRoutes.splash.name,
      path: AppRoutes.splash.path,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutes.getStarted.name,
      path: AppRoutes.getStarted.path,
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(DependencyInjection.authRepository),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.signup.name,
      path: AppRoutes.signup.path,
      builder: (context, state) => const SignupScreen(),
    ),

    // Authenticated routes with bottom nav
    GoRoute(
      name: AppRoutes.codeScreen.name,
      path: AppRoutes.codeScreen.path,
      builder: (context, state) => CodeScreen(
        isCopyCode: state.pathParameters['isCopyCode'] == 'true',
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BaseLayout(
          currentRoute: state.name ?? AppRoutes.home.name,
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: HomeScreen(),
            transitionsBuilder: (context, animation, _, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0), // start from left
                  end: Offset.zero, // end at current position
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          name: AppRoutes.gallery.name,
          path: AppRoutes.gallery.path,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: GalleryScreen(),
            transitionsBuilder: (context, animation, _, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1), // start from bottom
                  end: Offset.zero, // end at current position
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          name: AppRoutes.profile.name,
          path: AppRoutes.profile.path,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: ProfileScreen(),
            transitionsBuilder: (context, animation, _, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // start from right
                  end: Offset.zero, // end at current position
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          name: AppRoutes.bucketList.name,
          path: AppRoutes.bucketList.path,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: BucketListScreen(),
            transitionsBuilder: (context, animation, _, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1), // start from bottom
                  end: Offset.zero, // end at current position
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        ),
      ],
    ),

    // Modal routes (no bottom nav)
    GoRoute(
      name: AppRoutes.chats.name,
      path: AppRoutes.chats.path,
      builder: (context, state) => const ChatsScreen(),
    ),
    GoRoute(
      name: AppRoutes.settings.name,
      path: AppRoutes.settings.path,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: AppRoutes.themeSettings.name,
      path: AppRoutes.themeSettings.path,
      builder: (context, state) => const ThemeSettingsScreen(),
    ),
    GoRoute(
      name: AppRoutes.chatTheme.name,
      path: AppRoutes.chatTheme.path,
      builder: (context, state) => const ChatThemeSettings(),
    ),
    GoRoute(
      name: AppRoutes.notifications.name,
      path: AppRoutes.notifications.path,
      builder: (context, state) => const NotificationsScreen(),
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(
    errorMessage: state.error.toString(),
  ),
);
