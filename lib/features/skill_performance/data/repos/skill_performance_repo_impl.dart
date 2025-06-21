import 'package:dartz/dartz.dart';

import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/skill_performance/data/data_sources/skill_performance_data_source.dart';
import 'package:quizly_app/features/skill_performance/domain/repos/skill_performance_repo.dart';

class SkillPerformanceRepoImpl extends SkillPerformanceRepo {
  SkillPerformanceDataSource skillPerformanceDataSource;
  SkillPerformanceRepoImpl({required this.skillPerformanceDataSource});
  @override
  Future<Either<Failure, int>> createQuiz(int? skillId) async {
    try {
      final quizId = await skillPerformanceDataSource.createQuiz(skillId);
      return Right(quizId);
    } catch (e) {
      return Left(DatabaseFailure.insertError(table: "quizzes"));
    }
  }
  
}
