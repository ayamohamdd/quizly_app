import 'package:get_it/get_it.dart';
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/units/data/data_sources/units_data_source.dart';
import 'package:quizly_app/features/units/data/repos/units_repo_impl.dart';
import 'package:quizly_app/features/units/domain/repos/units_repo.dart';
import 'package:quizly_app/features/units/domain/use_cases/units_use_case.dart';
import 'package:quizly_app/features/units/presentation/manager/cubit/unit_cubit.dart';

class SetupSeviceLocator {
  static final sl = GetIt.asNewInstance();

  static Future<void> init() async {
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
  }

  static void registerRepositories() {
    sl.registerLazySingleton<UnitsRepo>(
      () => UnitsRepoImpl(unitsDataSource: sl<UnitsDataSource>()),
    );
  }

  static void registerUseCases() {
    sl.registerLazySingleton<UnitsUseCase>(
      () => UnitsUseCase(unitsRepo: sl<UnitsRepo>()),
    );
  }

  static void registerCubits() {
    sl.registerLazySingleton<UnitsCubit>(() => UnitsCubit());
  }

  static void registerCore() {
    sl.registerSingleton<SqfliteProvider>(SqfliteProvider());
  }
}
