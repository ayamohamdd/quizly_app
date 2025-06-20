

import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/quiz/data/models/mcq_options_model.dart';
import 'package:quizly_app/features/quiz/data/models/quiz_question_model.dart';
import 'package:quizly_app/features/quiz/domain/entities/mcq_options_entity.dart';

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
    List<QuizQuestionModel> questions = [];

    for (final map in response) {
      final question = QuizQuestionModel.fromDatabase(map);
      if (question.type == 'mcq' && question.id != null) {
        final options = await fetchMcqOptions(question.id!);
        question.mcqOptions = options;
      }
      questions.add(question);
    }
    return questions;
  }

  Future<List<McqOptionsEntity>> fetchMcqOptions(int questionId) async {
    final result = await sqfliteProvider.getMcqOptions(questionId);
    List<McqOptionsEntity> options =
        result.map((row) => McqOptionsModel.fromDatabase(row) as McqOptionsEntity).toList();
    return options;
  }
}
