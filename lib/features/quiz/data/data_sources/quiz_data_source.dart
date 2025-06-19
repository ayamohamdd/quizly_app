// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/quiz/data/models/quiz_question_model.dart';

abstract class QuizDataSource {
  Future<List<QuizQuestionModel>> fetchQuizQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  );
}

class QuizDataSourceImpl extends QuizDataSource {
  SqfliteProvider sqfliteProvider;
  QuizDataSourceImpl({required this.sqfliteProvider});

  @override
  Future<List<QuizQuestionModel>> fetchQuizQuestions(
    int skillId,
    List<String> levels,
    int numberOfQuestions,
  ) async {
    List<Map<String, dynamic>> response = await sqfliteProvider.getQuestions(
      skillId,
      levels,
      numberOfQuestions,
    );
    List<QuizQuestionModel> questions =
        response.map((map) => QuizQuestionModel.fromDatabase(map)).toList();
    return questions;
  }
}
