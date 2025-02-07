import 'package:flutter/material.dart';

import 'core/app_router.dart';
import 'core/dependency_injection.dart';
import 'presentation/themes/colors.dart';

void main() {
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: cPrimaryLight,
      ),
      routerConfig: appRouter,
    );
  }
}
