import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';

abstract class SkillPerformanceRepo {
  Future<Either<Failure, int>> createQuiz(int? skillId);
}
