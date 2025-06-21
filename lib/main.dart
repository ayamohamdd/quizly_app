import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/core/utils/bloc_observer.dart';
import 'package:quizly_app/core/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupSeviceLocator.init();
  // Bloc.observer = const SimpleBlocObserver();
  SqfliteProvider sqfliteProvider = SqfliteProvider();
  log("message ${await sqfliteProvider.getQuizScorePerLevel( 13)}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'Quizly App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.appRouter,
      theme: AppTheme.lightTheme,
    );
  }
}
