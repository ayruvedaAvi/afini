import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_router.dart';
import '../../themes/colors.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = [];
    _animations = [];

    // Create 8 controllers for 8 shapes
    for (int i = 0; i < 8; i++) {
      final controller = AnimationController(
        duration: Duration(
          milliseconds:
              1000 + _random.nextInt(2000), // Random duration between 1-3s
        ),
        vsync: this,
      );

      final animation = Tween<double>(
        begin: 0.3 + _random.nextDouble() * 0.4, // Random start opacity
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));

      _controllers.add(controller);
      _animations.add(animation);

      // Start animation with random delay
      Future.delayed(Duration(milliseconds: _random.nextInt(1000)), () {
        controller.repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildTwinklingShape(
    int index,
    double directionX,
    double intDirectionY,
    BoxShape shape,
    double width,
    double height,
    Color color,
  ) {
    return Align(
      alignment: AlignmentDirectional(directionX, intDirectionY),
      child: AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) {
          return Opacity(
            opacity: _animations[index].value,
            child: Transform.scale(
              scale: 0.8 + (_animations[index].value * 0.4), // Scale effect
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  shape: shape,
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(150),
                      blurRadius: 8 * _animations[index].value,
                      spreadRadius: 2 * _animations[index].value,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cPrimaryDark,
              cSecondaryDark,
            ],
          ),
        ),
        child: Stack(
          children: [
            buildTwinklingShape(
                0, 0.5, 0.1, BoxShape.circle, 50, 50, Colors.blue),
            buildTwinklingShape(
                1, -0.8, 0.3, BoxShape.rectangle, 20, 20, Colors.blue),
            buildTwinklingShape(
                2, 0.2, 0.5, BoxShape.circle, 20, 20, Colors.pink),
            buildTwinklingShape(
                3, 0.7, -0.7, BoxShape.rectangle, 50, 50, Colors.green),
            buildTwinklingShape(
                4, -0.4, -0.9, BoxShape.circle, 30, 30, Colors.yellow),
            buildTwinklingShape(
                5, 0.9, 0.9, BoxShape.rectangle, 30, 30, Colors.orange),
            buildTwinklingShape(
                6, -0.6, 0.7, BoxShape.circle, 40, 40, Colors.purple),
            buildTwinklingShape(
                7, -0.6, -0.1, BoxShape.rectangle, 25, 30, Colors.red),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Image.asset('assets/images/logo.png',
                            width: MediaQuery.of(context).size.width * 0.35),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Affini',
                        style: GoogleFonts.pacifico(
                          fontSize: 24,
                          color: const Color.fromARGB(255, 173, 65, 175),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Create your own private space.',
                        style: GoogleFonts.pacifico(
                          fontSize: 16,
                          color: Color.fromARGB(255, 85, 17, 86),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.signup.name);
                          },
                          child: const Text('Get Started',
                              style: TextStyle(
                                fontSize: 18,
                                color: cPrimaryDark,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.login.name);
                        },
                        child: const Text(
                          'Already have an account? Log in..',
                          style: TextStyle(
                            color: Color.fromARGB(255, 85, 17, 86),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
