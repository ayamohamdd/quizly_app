import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';
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

  @override
  Future<Either<Failure, List<QuizPerformanceModel>>> getSkillPerformance(
    int? skillId,
  ) async {
    try {
      final response = await skillPerformanceDataSource.getSkillPerformance(
        skillId,
      );
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure.queryError());
    }
  }

  @override
  Future<Either<Failure, List<QuizWrongQuestionModel>>>
  fetchSkillWrongQuestions(int? skillId) async {
    try {
      final response = await skillPerformanceDataSource.fetchWrongQuestions(
        skillId,
      );
      log("repo $response");
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure.queryError());
    }
  }
}
