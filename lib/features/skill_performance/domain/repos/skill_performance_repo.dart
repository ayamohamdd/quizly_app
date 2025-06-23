import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';

abstract class SkillPerformanceRepo {
  Future<Either<Failure, int>> createQuiz(int? skillId);
  Future<Either<Failure, List<QuizPerformanceModel>>> getSkillPerformance(
    int? skillId,
  );
  Future<Either<Failure, List<QuizWrongQuestionModel>>>
  fetchSkillWrongQuestions(int? skillId);
}
