import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly_app/core/app_router/app_routers.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/core/utils/bloc_observer.dart';
import 'package:quizly_app/core/utils/theme/app_theme.dart';
import 'package:quizly_app/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupSeviceLocator.init();
  // QuizDataSource quizDataSource = QuizDataSourceImpl(
  //   sqfliteProvider: SetupSeviceLocator.sl.get(),
  // );
  // quizDataSource.fetchQuizQuestions(1, ["easy", "hard"], 25);
  Bloc.observer = const SimpleBlocObserver();
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
