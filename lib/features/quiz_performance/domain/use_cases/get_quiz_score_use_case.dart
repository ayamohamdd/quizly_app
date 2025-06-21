import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';

class GetQuizScoreUseCase
    extends UseCase<Either<String, double>, List<QuizPerformanceModel>> {
  final QuizPerformanceRepo quizPerformanceRepo;

  GetQuizScoreUseCase({required this.quizPerformanceRepo});

  @override
  Either<String, double> call([List<QuizPerformanceModel>? quizPerformance]) {
    return quizPerformanceRepo.getQuizScore(quizPerformance!);
  }
}
