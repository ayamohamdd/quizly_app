import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';

class GetQuizPerformanceUseCase
    extends UseCase<Future<Either<Failure, List<QuizPerformanceModel>>>, int?> {
  final QuizPerformanceRepo quizPerformanceRepo;

  GetQuizPerformanceUseCase({required this.quizPerformanceRepo});

  @override
  Future<Either<Failure, List<QuizPerformanceModel>>> call([
    int? quizId,
  ]) async {
    return await quizPerformanceRepo.getQuizPerformancePerLevel(quizId);
  }
}
