import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../themes/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  Widget buildRandomShapes(double directionX, double intDirectionY,
      BoxShape shape, double width, double height, Color color) {
    return Align(
      alignment: AlignmentDirectional(directionX, intDirectionY),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
        ),
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
            buildRandomShapes(0.5, 0.1, BoxShape.circle, 50, 50, Colors.blue),
            buildRandomShapes(
                -0.8, 0.3, BoxShape.rectangle, 20, 20, Colors.blue),
            buildRandomShapes(0.2, 0.5, BoxShape.circle, 20, 20, Colors.pink),
            buildRandomShapes(
                0.7, -0.7, BoxShape.rectangle, 50, 50, Colors.green),
            buildRandomShapes(
                -0.4, -0.9, BoxShape.circle, 30, 30, Colors.yellow),
            buildRandomShapes(
                0.9, 0.9, BoxShape.rectangle, 30, 30, Colors.orange),
            buildRandomShapes(
                -0.6, 0.7, BoxShape.circle, 40, 40, Colors.purple),
            buildRandomShapes(
                -0.6, -0.1, BoxShape.rectangle, 25, 30, Colors.red),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 350),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed('signup');
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
                          context.pushNamed('login');
                        },
                        child: const Text('Already have an account? Log in..',
                            style: TextStyle(
                                color: Color.fromARGB(255, 48, 46, 46))),
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
