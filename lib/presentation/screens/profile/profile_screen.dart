import 'package:flutter/material.dart';

import '../support/custom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'Profile Screen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This is the profile screen.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(
        selectedIndex: 3,
      ),
    );
  }
}
