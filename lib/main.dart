import 'package:affini/presentation/themes/colors.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/get_started_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/get-started':
            return MaterialPageRoute(
                builder: (context) => const GetStartedScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          default:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: cPrimaryLight,
      ),
      home: const SplashScreen(),
    );
  }
}
