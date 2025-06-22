import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';

abstract class QuizPerformanceRepo {
  Future<Either<Failure, List<QuizPerformanceModel>>>
  getQuizPerformancePerLevel(int? quizId);
  double getQuizScore(List<QuizPerformanceModel> quizPerformance);

  Future<Either<Failure, List<QuizWrongQuestionModel>>> fetchQuizWrongQuestions(
    int? quizId,
  );
}
