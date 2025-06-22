import 'package:get_it/get_it.dart';
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:quizly_app/features/quiz/data/repos/quiz_repo_impl.dart';
import 'package:quizly_app/features/quiz/domain/repos/quiz_repo.dart';
import 'package:quizly_app/features/quiz/domain/use_cases/fetch_questions_use_case.dart';
import 'package:quizly_app/features/quiz/domain/use_cases/insert_quiz_question_use_case.dart';
import 'package:quizly_app/features/quiz/presentation/manager/cubit/quiz_cubit.dart';
import 'package:quizly_app/features/quiz_performance/data/data_source/quiz_performance_data_source.dart';
import 'package:quizly_app/features/quiz_performance/data/repos/quiz_performance_repo_impl.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/fetch_quiz_wrong_questions_use_case.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/get_quiz_performance_use_case.dart';
import 'package:quizly_app/features/quiz_performance/domain/use_cases/get_quiz_score_use_case.dart';
import 'package:quizly_app/features/quiz_performance/presentation/manager/cubit/quiz_performance_cubit.dart';
import 'package:quizly_app/features/skill_performance/data/data_sources/skill_performance_data_source.dart';
import 'package:quizly_app/features/skill_performance/data/repos/skill_performance_repo_impl.dart';
import 'package:quizly_app/features/skill_performance/domain/repos/skill_performance_repo.dart';
import 'package:quizly_app/features/skill_performance/domain/use_cases/create_quiz_use_case.dart';
import 'package:quizly_app/features/skill_performance/presentation/manager/cubit/skill_performance_cubit.dart';
import 'package:quizly_app/features/skills/data/data_sources/skills_data_source.dart';
import 'package:quizly_app/features/skills/data/repos/skills_repo_impl.dart';
import 'package:quizly_app/features/skills/domain/repos/skills_repo.dart';
import 'package:quizly_app/features/skills/domain/use_cases/skills_use_case.dart';
import 'package:quizly_app/features/skills/presentation/manager/cubit/skills_cubit.dart';
import 'package:quizly_app/features/units/data/data_sources/units_data_source.dart';
import 'package:quizly_app/features/units/data/repos/units_repo_impl.dart';
import 'package:quizly_app/features/units/domain/repos/units_repo.dart';
import 'package:quizly_app/features/units/domain/use_cases/units_use_case.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_cubit.dart';

class SetupSeviceLocator {
  static final sl = GetIt.asNewInstance();

  static Future<void> init() async {
    await SqfliteProvider.database;

    registerDataSources();
    registerRepositories();
    registerUseCases();
    registerCubits();
    registerCore();
  }

  static void registerDataSources() {
    sl.registerLazySingleton<UnitsDataSource>(
      () => UnitsDataSourceImpl(sqfliteProvider: sl.get()),
    );
    sl.registerLazySingleton<SkillsDataSource>(
      () => SkillsDataSourceImpl(sqfliteProvider: sl.get()),
    );
    sl.registerLazySingleton<SkillPerformanceDataSource>(
      () => SkillPerformanceDataSourceImpl(sqfliteProvider: sl.get()),
    );
    sl.registerLazySingleton<QuizDataSource>(
      () => QuizDataSourceImpl(sqfliteProvider: sl.get()),
    );
    sl.registerLazySingleton<QuizPerformanceDataSource>(
      () => QuizPerformanceDataSourceImpl(sqfliteProvider: sl.get()),
    );
  }

  static void registerRepositories() {
    sl.registerLazySingleton<UnitsRepo>(
      () => UnitsRepoImpl(unitsDataSource: sl<UnitsDataSource>()),
    );
    sl.registerLazySingleton<SkillsRepo>(
      () => SkillsRepoImpl(skillsDataSource: sl<SkillsDataSource>()),
    );
    sl.registerLazySingleton<SkillPerformanceRepo>(
      () => SkillPerformanceRepoImpl(
        skillPerformanceDataSource: sl<SkillPerformanceDataSource>(),
      ),
    );
    sl.registerLazySingleton<QuizRepo>(
      () => QuizRepoImpl(quizDataSource: sl<QuizDataSource>()),
    );
    sl.registerLazySingleton<QuizPerformanceRepo>(
      () => QuizPerformanceRepoImpl(
        quizPerformanceDataSource: sl<QuizPerformanceDataSource>(),
      ),
    );
  }

  static void registerUseCases() {
    sl.registerLazySingleton<UnitsUseCase>(
      () => UnitsUseCase(unitsRepo: sl<UnitsRepo>()),
    );
    sl.registerLazySingleton<SkillsUseCase>(
      () => SkillsUseCase(skillsRepo: sl<SkillsRepo>()),
    );

    sl.registerLazySingleton<CreateQuizUseCase>(
      () => CreateQuizUseCase(skillPerformanceRepo: sl<SkillPerformanceRepo>()),
    );

    sl.registerLazySingleton<FetchQuestionsUseCase>(
      () => FetchQuestionsUseCase(quizRepo: sl<QuizRepo>()),
    );
    sl.registerLazySingleton<InsertQuizQuestionUseCase>(
      () => InsertQuizQuestionUseCase(quizRepo: sl<QuizRepo>()),
    );

    sl.registerLazySingleton<GetQuizPerformanceUseCase>(
      () => GetQuizPerformanceUseCase(
        quizPerformanceRepo: sl<QuizPerformanceRepo>(),
      ),
    );
    sl.registerLazySingleton<GetQuizScoreUseCase>(
      () => GetQuizScoreUseCase(quizPerformanceRepo: sl<QuizPerformanceRepo>()),
    );
    sl.registerLazySingleton<FetchQuizWrongQuestionsUseCase>(
      () => FetchQuizWrongQuestionsUseCase(
        quizPerformanceRepo: sl<QuizPerformanceRepo>(),
      ),
    );
  }

  static void registerCubits() {
    sl.registerFactory<UnitsCubit>(() => UnitsCubit());
    sl.registerFactory<SkillsCubit>(() => SkillsCubit());
    sl.registerFactory<SkillPerformanceCubit>(() => SkillPerformanceCubit());
    sl.registerFactory<QuizCubit>(() => QuizCubit());
    sl.registerFactory<QuizPerformanceCubit>(() => QuizPerformanceCubit());
  }

  static void registerCore() {
    sl.registerSingleton<SqfliteProvider>(SqfliteProvider());
  }
}
