import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz/domain/entities/insert_quiz_question_param_entity.dart';
import 'package:quizly_app/features/quiz/domain/repos/quiz_repo.dart';

class InsertQuizQuestionUseCase
    extends
        UseCase<Future<Either<Failure, int>>, InsertQuizQuestionParamEntity> {
  final QuizRepo quizRepo;

  InsertQuizQuestionUseCase({required this.quizRepo});

  @override
  Future<Either<Failure, int>> call([
    InsertQuizQuestionParamEntity? params,
  ]) async {
    return await quizRepo.insertQuizQuestion(
      params!.quizId!,
      params.questionId!,
      params.questionLevel!,
      params.userAnswer,
      params.isCorrect,
    );
  }
}
