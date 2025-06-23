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
import 'package:quizly_app/features/quiz_performance/data/data_source/quiz_performance_data_source.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/repos/quiz_performance_repo_impl.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/fetch_quiz_wrong_questions_use_case.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SetupSeviceLocator.init();
  Bloc.observer = const SimpleBlocObserver();
  SqfliteProvider sqfliteProvider = SqfliteProvider();
  log("${await sqfliteProvider.getSkillsPerformance(1)}");

  // List<QuizPerformanceModel> q = await quizPerformanceDataSource
  //     .getQuizPerformancePerLevel(33);
  // if (q.isNotEmpty) {
  //   log("message ${quizPerformanceDataSource.getQuizScore(q)}");
  // }
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
