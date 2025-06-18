import 'package:flutter/material.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/utils/theme/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SetupSeviceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
