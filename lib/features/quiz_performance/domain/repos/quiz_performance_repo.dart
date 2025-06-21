import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/entities/quiz_performance_entity.dart';

abstract class QuizPerformanceRepo {
  Future<Either<Failure, List<QuizPerformanceEntity>>>
  getQuizPerformancePerLevel(int? quizId);
  Either<String, double> getQuizScore(
    List<QuizPerformanceModel> quizPerformance,
  );
}
