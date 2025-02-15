import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../themes/colors.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Align(
              alignment: const AlignmentDirectional(0.0, -0.8),
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(56),
                      topRight: Radius.circular(56),
                    ),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hello text
                      const Center(
                        child: Text(
                          'hello!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: cPrimaryDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Username field
                      CustomTextField(
                          validator: () {},
                          hintText: "Full Name",
                          isPassword: false,
                          controller: TextEditingController(),
                          icon: Icons.person_outline),
                      const SizedBox(height: 16),

                      // Email field
                      CustomTextField(
                          validator: () {},
                          hintText: "Email",
                          isPassword: false,
                          controller: TextEditingController(),
                          icon: Icons.email_outlined),
                      const SizedBox(height: 16),

                      // Password field
                      CustomTextField(
                          validator: () {},
                          hintText: "Password",
                          isPassword: true,
                          controller: TextEditingController(),
                          icon: Icons.lock_outline),
                      const SizedBox(height: 16),

                      // Terms and conditions
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'I agree to the terms and conditions',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Sign Up button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed('code-screen', pathParameters: {
                              'isCopyCode': 'true',
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cSecondaryDark,
                            elevation: 2,
                            shadowColor: cPrimaryDark,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Social media login
                      Column(
                        children: [
                          const Text(
                            'Log in with google!',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _SocialButton(
                                  color: Colors.red, onPressed: () {}),
                              const SizedBox(width: 16),
                              _SocialButton(
                                  color: Colors.orange, onPressed: () {}),
                              const SizedBox(width: 16),
                              _SocialButton(
                                  color: Colors.blue, onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
