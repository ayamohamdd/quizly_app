import 'package:flutter/material.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/utils/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quizly App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.appRouter,
      theme: AppTheme.lightTheme,
    );
  }
}
