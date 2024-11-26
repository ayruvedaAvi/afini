import 'package:flutter/material.dart';

import 'components/buttom_nav_bar.dart';
import 'home_screen.dart';

class BaseLayout extends StatefulWidget {
  final int index;
  const BaseLayout({super.key, required this.index});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  final controller = PageController();
  int index = 0;
  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: controller,
        onPageChanged: (value) => setState(() => index = value),
        children: <Widget>[
          const HomeScreen(),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        curentIndex: index,
        backgroundColor: Colors.blue,
        onTap: (value) => setState(() {
          index = value;
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }),
        children: [
          BottomNavBarItem(
            title: "Home",
            icon: Icons.home_outlined,
          ),
          BottomNavBarItem(
            title: "Search",
            icon: Icons.search_rounded,
          ),
          BottomNavBarItem(
            title: 'Chat',
            icon: Icons.chat_bubble_outline,
          ),
          BottomNavBarItem(
            title: "Profile",
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}
