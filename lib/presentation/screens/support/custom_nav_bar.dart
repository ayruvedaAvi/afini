import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/app_router.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home.name);
        break;
      case 1:
        context.goNamed(AppRoutes.gallery.name);
        break;
      case 2:
        context.goNamed(AppRoutes.bucketList.name);
        break;
      case 3:
        context.goNamed(AppRoutes.profile.name);
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
          haptic: true,
          curve: Curves.slowMiddle,
          textStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          tabBackgroundGradient: LinearGradient(
            colors: [
              const Color.fromARGB(130, 226, 205, 226),
              Theme.of(context).colorScheme.primary.withAlpha(150),
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
              text: 'Memories',
            ),
            GButton(
              icon: Icons.format_list_bulleted_sharp,
              text: 'Buck List',
            ),
            GButton(
              icon: Icons.person_outlined,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
