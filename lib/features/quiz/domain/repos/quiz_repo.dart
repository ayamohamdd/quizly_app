import 'package:dartz/dartz.dart';
import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz/domain/entities/quiz_question_entity.dart';

abstract class QuizRepo {
  Future<Either<Failure, List<QuizQuestionEntity>>> fetchQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  );
   Future<Either<Failure,void>> insertQuizQuestion(
    int? quizId,
    int? questionId,
    String? userAnswer,
    int? isCorrect,
  );
}
