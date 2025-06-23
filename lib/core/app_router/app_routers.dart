import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quizly_app/core/di/setup_service_locator.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz/presentation/views/pre_quiz_views/pre_quiz_view.dart';
import 'package:quizly_app/features/quiz/presentation/views/quiz_views/quiz_view.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_cubit.dart';
import 'package:quizly_app/features/quiz_performance/presentation/views/quiz_performance_view.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_cubit.dart';
import 'package:quizly_app/features/skill_performance/presentation/views/skill_performance_view.dart';
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
  static const String quizPerformanceView = '/quizPerformance';

  static const String skillsView = '/skillsView';
  static const String skillPerformanceView = '/skillPerformanceView';

  static final appRouter = GoRouter(
    initialLocation: unitsView,
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
        path: skillPerformanceView,
        builder: (context, state) {
          final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          int? skillId = extra["skill_id"];
          String? skillName = extra["skill_name"];
          return BlocProvider.value(
            value:
                SetupSeviceLocator.sl<SkillPerformanceCubit>()
                  ..getSkillWrongQuestions(skillId ?? 0)
                  ..getSkillPerformance(skillId ?? 0),
            child: SkillPerformanceView(skillId: skillId, skillName: skillName!),
          );
        },
      ),
      GoRoute(
        path: preQuizView,
        builder: (context, state) {
          final Map<String, int?> extra = state.extra as Map<String, int?>;
          final int quizId = extra["quiz_id"]!;
          final int skillId = extra["skill_id"]!;

          return BlocProvider.value(
            value: SetupSeviceLocator.sl<QuizCubit>(),
            child: PreQuizView(quizId: quizId, skillId: skillId),
          );
        },
      ),
      GoRoute(
        path: AppRouter.quizView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final int quizId = extra['quizId'];
          final QuizCubit cubit = extra['cubit'];

          return BlocProvider.value(
            value: cubit,
            child: QuizView(quizId: quizId),
          );
        },
      ),

      GoRoute(
        path: quizPerformanceView,
        builder: (context, state) {
          final int? quizId = state.extra as int?;
          return BlocProvider.value(
            value:
                SetupSeviceLocator.sl<QuizPerformanceCubit>()
                  ..getQuizPerformance(quizId ?? 0)
                  ..getQuizWrongQuestions(quizId ?? 0),
            child: QuizPerformanceView(),
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
