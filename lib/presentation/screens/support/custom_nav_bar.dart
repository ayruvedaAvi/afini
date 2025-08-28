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
        context.goNamed('home');
        break;
      case 1:
        context.goNamed('gallery');
        break;
      case 2:
        context.goNamed('notifications');
        break;
      case 3:
        context.goNamed('profile');
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
            Colors.black.withAlpha(102),
            Colors.black.withAlpha(75),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GNav(
          padding: const EdgeInsets.all(12),
          backgroundColor: Colors.transparent,
          color: Colors.white.withAlpha(180),
          activeColor: Colors.white,
          tabBackgroundGradient: LinearGradient(
            colors: [
              const Color.fromARGB(130, 226, 205, 226),
              Colors.purple.withAlpha(130),
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
              icon: Icons.photo_library_outlined,
              text: 'Gallery',
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
