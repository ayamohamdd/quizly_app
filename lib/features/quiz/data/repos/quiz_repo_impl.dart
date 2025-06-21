// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:quizly_app/core/utils/errors/failure.dart';
import 'package:quizly_app/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:quizly_app/features/quiz/data/models/quiz_question_model.dart';
import 'package:quizly_app/features/quiz/domain/repos/quiz_repo.dart';

class QuizRepoImpl extends QuizRepo {
  QuizDataSource quizDataSource;
  QuizRepoImpl({required this.quizDataSource});
  @override
  Future<Either<Failure, List<QuizQuestionModel>>> fetchQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  ) async {
    try {
      final questions = await quizDataSource.fetchQuizQuestions(
        skillId,
        levels,
        numberOfQuestions,
      );
      return Right(questions);
    } catch (e) {
      return Left(DatabaseFailure.queryError(query: "SELECT * FROM questions"));
    }
  }

  @override
  Future<Either<Failure, int>> insertQuizQuestion(
    int? quizId,
    int? questionId,
    String? questionLevel,
    String? userAnswer,
    int? isCorrect,
  ) async {
    try {
      final id = await quizDataSource.insertQuizQuestion(
        quizId!,
        questionId!,
        questionLevel!,
        userAnswer!,
        isCorrect!,
      );
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure.insertError(table: "quiz_questions"));
    }
  }
}
