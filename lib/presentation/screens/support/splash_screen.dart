// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../core/token_storage.dart';
import '../../../data/respository/rem_auth_repo.dart';
import '../../themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          final refreshToken = await TokenStorage.getRefreshToken();
          if (refreshToken == null) {
            context.goNamed('get-started');
          }
          if (JwtDecoder.isExpired(refreshToken!)) {
            try {
              await RemAuthRepo().logout();
              context.goNamed('login');
            } catch (e) {
              debugPrint('Error: $e');
              //show snackbar if necessary
            }
          } else {
            context.goNamed('home');
          }
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 45, 45),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 300),
              Text(
                'Affini',
                style:
                    GoogleFonts.pacifico(fontSize: 24, color: cSecondaryLight),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(cSecondaryLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
