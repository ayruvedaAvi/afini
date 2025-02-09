import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.pushNamed('home');
        break;
      case 1:
        context.pushNamed('chat');
        break;
      case 2:
        context.pushNamed('notifications');
        break;
      case 3:
        context.pushNamed('profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.3),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GNav(
          padding: const EdgeInsets.all(12),
          backgroundColor: Colors.transparent,
          color: Colors.white.withOpacity(0.7),
          activeColor: Colors.white,
          tabBackgroundGradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 226, 205, 226).withOpacity(0.5),
              Colors.purple.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          gap: 8,
          selectedIndex: selectedIndex,
          onTabChange: (index) => _onItemTapped(context, index),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.chat_bubble_outline_rounded,
              text: 'Chat',
            ),
            GButton(
              icon: Icons.notifications_none,
              text: 'Notifications',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
