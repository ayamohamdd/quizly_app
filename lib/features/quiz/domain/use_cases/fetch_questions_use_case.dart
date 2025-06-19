import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/core/utils/use_cases/use_case.dart';
import 'package:quizly_app/features/quiz/domain/entities/fetch_questions_param_entity.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';
import 'package:quizly_app/features/quiz/domain/repos/quiz_repo.dart';

class FetchQuestionsUseCase
    extends UseCase<Future<Either<Failure, List<QuizQuestionEntity>>>, FetchQuestionsParamEntity> {
  final QuizRepo quizRepo;

  FetchQuestionsUseCase({required this.quizRepo});

  @override
  Future<Either<Failure, List<QuizQuestionEntity>>> call([FetchQuestionsParamEntity? params]) async {
    return await quizRepo.fetchQuestions(params!.skillId,params.levels,params.numberOfQuestions);
  }
}

