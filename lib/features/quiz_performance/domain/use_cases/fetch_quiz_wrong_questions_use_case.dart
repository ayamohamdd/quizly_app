import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';
import 'package:quizly_app/features/quiz_performance/domain/repos/quiz_performance_repo.dart';

class FetchQuizWrongQuestionsUseCase
    extends
        UseCase<Future<Either<Failure, List<QuizWrongQuestionModel>>>, int?> {
  final QuizPerformanceRepo quizPerformanceRepo;

  FetchQuizWrongQuestionsUseCase({required this.quizPerformanceRepo});

  @override
  Future<Either<Failure, List<QuizWrongQuestionModel>>> call([
    int? quizId,
  ]) async {
    final response = await quizPerformanceRepo.fetchQuizWrongQuestions(quizId);
    ("use case $response");
    return response;
  }
}
