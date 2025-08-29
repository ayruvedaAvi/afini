// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rive/rive.dart';

import '../../../core/token_storage.dart';
import '../../../data/respository/rem_auth_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  RiveAnimationController? _riveController;
  bool _isRiveLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          final refreshToken = await TokenStorage.getRefreshToken();
          if (refreshToken == null) {
            context.goNamed('get-started');
            return;
          }
          if (JwtDecoder.isExpired(refreshToken)) {
            try {
              await RemAuthRepo().logout();
              context.goNamed('login');
            } catch (e) {
              debugPrint('Error: $e');
              context.goNamed('login');
            }
          } else {
            context.goNamed('home');
          }
        }
      });

    _controller.forward();
  }

  void _initializeAnimation() {
    _riveController = SimpleAnimation('Animation 1');
    setState(() => _isRiveLoaded = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _riveController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                child: _isRiveLoaded
                    ? RiveAnimation.asset(
                        'assets/animations/splash.riv',
                        controllers:
                            _riveController != null ? [_riveController!] : [],
                        fit: BoxFit.contain,
                        onInit: (artboard) {
                          debugPrint('Rive animation loaded successfully');
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.animation,
                            color: Color.fromARGB(255, 227, 94, 230),
                            size: 50,
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.12,
                left: MediaQuery.of(context).size.width * 0.34,
                child: Column(
                  children: [
                    Text(
                      'Affini',
                      style: GoogleFonts.pacifico(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 227, 94, 230),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 227, 94, 230)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
