import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/views/pre_quiz_views/pre_quiz_view.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/quiz_view.dart';
import 'package:quizly_app/features/skills/presentation/manager/cubit/skills_cubit.dart';
import 'package:quizly_app/features/skills/presentation/views/skills_view.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_cubit.dart';
import 'package:quizly_app/features/units/presentation/views/units_view.dart';

class AppRouter {
  // static const String splashView = '/';
  static const String mainNavigationView = '/main';
  static const String unitsView = '/unitView';
  static const String preQuizView = '/preQuizView';
  static const String quizView = '/quizView';

  static const String skillsView = '/skillsView';

  static final appRouter = GoRouter(
    initialLocation: preQuizView,
    routes: [
      GoRoute(
        path: unitsView,
        builder: (context, state) {
          return BlocProvider.value(
            value: SetupSeviceLocator.sl<UnitsCubit>()..fetchUnits(),
            child: UnitsView(),
          );
        },
      ),
      GoRoute(
        path: skillsView,
        builder: (context, state) {
          final int? unitId = state.extra as int?;
          return BlocProvider.value(
            value: SetupSeviceLocator.sl<SkillsCubit>()..fetchSkills(unitId),
            child: SkillsView(),
          );
        },
      ),
      GoRoute(
        path: preQuizView,
        builder: (context, state) {
          return BlocProvider.value(
            value: SetupSeviceLocator.sl<QuizCubit>(),
            child: PreQuizView(),
          );
        },
      ),
      GoRoute(
        path: quizView,
        builder: (context, state) {
          return BlocProvider.value(
            value: SetupSeviceLocator.sl<QuizCubit>(),
            child: QuizView(),
          );
        },
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
  );
}
