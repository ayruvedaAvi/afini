import 'package:flutter/material.dart';

import '../themes/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/logo.png', width: 400),
            const SizedBox(height: 24),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen
                      Navigator.pushNamed(context, '/signup');
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
                    // Navigate to the next screen
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Already have an account? Log in',
                      style: TextStyle(color: cPrimaryLight)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
