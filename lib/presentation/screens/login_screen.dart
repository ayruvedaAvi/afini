import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add this import
import 'package:go_router/go_router.dart';

import '../../domain/repositories/user_repository.dart';
import '../cubits/auth/auth_cubit.dart';
import '../themes/colors.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingControllers for email and password
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(context.read<UserRepository>()), // Provide AuthCubit to the widget tree
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cPrimaryDark, cSecondaryDark],
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
                        const Center(
                          child: Text(
                            'welcome back!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: cPrimaryDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Email field
                        CustomTextField(
                          hintText: "Email",
                          isPassword: false,
                          controller: emailController,
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        CustomTextField(
                          hintText: "Password",
                          isPassword: true,
                          controller: passwordController,
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 16),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF6C3CE9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login button
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            // Handle login success or failure here
                            if (state.error != null) {
                              // Show error message if there's an error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error!)),
                              );
                            } else if (!state.isLoading) {
                              context.push('/home'); // Redirect on successful login
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Trigger login in the AuthCubit
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  context.read<AuthCubit>().login(email, password);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C3CE9),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: state.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Social media login
                        Column(
                          children: [
                            const Text(
                              'Log in with your social media account',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialButton(color: Colors.red, onPressed: () {}),
                                const SizedBox(width: 16),
                                _SocialButton(color: Colors.orange, onPressed: () {}),
                                const SizedBox(width: 16),
                                _SocialButton(color: Colors.blue, onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Sign up link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/signup');
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF6C3CE9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
