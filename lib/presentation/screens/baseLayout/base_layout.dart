import 'package:flutter/material.dart';

import '../support/custom_nav_bar.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const BaseLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  int _getSelectedIndex(String route) {
    switch (route) {
      case 'home':
        return 0;
      case 'gallery':
        return 1;
      case 'notifications':
        return 2;
      case 'profile':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _getSelectedIndex(currentRoute),
      ),
    );
  }
}