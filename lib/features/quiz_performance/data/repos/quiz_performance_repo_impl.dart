import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:quizly_app/features/quiz_performance/data/data_source/quiz_performance_data_source.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';

class QuizPerformanceRepoImpl extends QuizPerformanceRepo {
  final QuizPerformanceDataSource quizPerformanceDataSource;

  QuizPerformanceRepoImpl({required this.quizPerformanceDataSource});
  @override
  Future<Either<Failure, List<QuizPerformanceModel>>>
  getQuizPerformancePerLevel(int? quizId) async {
    try {
      final response = await quizPerformanceDataSource
          .getQuizPerformancePerLevel(quizId);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure.queryError());
    }
  }

  @override
  double getQuizScore(List<QuizPerformanceModel> quizPerformance) {
    try {
      return quizPerformanceDataSource.getQuizScore(quizPerformance);
    } catch (e) {
      log("Error When calculate score");
      return 0;
    }
  }

  @override
  Future<Either<Failure, List<QuizWrongQuestionModel>>> fetchQuizWrongQuestions(
    int? quizId,
  ) async {
    try {
      final response = await quizPerformanceDataSource.fetchWrongQuestions(
        quizId,
      );
      log("repo $response");
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure.queryError());
    }
  }
}
