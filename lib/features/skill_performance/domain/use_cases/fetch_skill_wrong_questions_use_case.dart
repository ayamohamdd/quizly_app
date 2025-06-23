import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';
import 'package:quizly_app/features/skill_performance/domain/repos/skill_performance_repo.dart';

class FetchSkillWrongQuestionsUseCase
    extends
        UseCase<Future<Either<Failure, List<QuizWrongQuestionModel>>>, int?> {
  final SkillPerformanceRepo skillPerformanceRepo;

  FetchSkillWrongQuestionsUseCase({required this.skillPerformanceRepo});

  @override
  Future<Either<Failure, List<QuizWrongQuestionModel>>> call([
    int? skillId,
  ]) async {
    final response = await skillPerformanceRepo.fetchSkillWrongQuestions(
      skillId,
    );
    return response;
  }
}
