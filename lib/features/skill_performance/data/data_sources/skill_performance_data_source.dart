import 'dart:developer';

import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';

abstract class SkillPerformanceDataSource {
  Future<int> createQuiz(int? skillId);
  Future<List<QuizPerformanceModel>> getSkillPerformance(int? skillId);
  Future<List<QuizWrongQuestionModel>> fetchWrongQuestions(int? skillId);
}

class SkillPerformanceDataSourceImpl extends SkillPerformanceDataSource {
  SqfliteProvider sqfliteProvider;
  SkillPerformanceDataSourceImpl({required this.sqfliteProvider});
  @override
  Future<int> createQuiz(int? skillId) async {
    return await sqfliteProvider.insertQuiz(skillId!);
  }

  @override
  Future<List<QuizPerformanceModel>> getSkillPerformance(int? skillId) async {
    final skillPerformanceData = await sqfliteProvider.getSkillsPerformance(
      skillId!,
    );
    List<QuizPerformanceModel> skillPerformanceList =
        skillPerformanceData
            .map((map) => QuizPerformanceModel.fromDatabase(map))
            .toList();

    return skillPerformanceList;
  }

  @override
  Future<List<QuizWrongQuestionModel>> fetchWrongQuestions(int? skillId) async {
    final skillWrongQuestionsData = await sqfliteProvider
        .getSkillWrongQuestions(skillId!);
    List<QuizWrongQuestionModel> skillWrongQuestionsList =
        skillWrongQuestionsData
            .map((map) => QuizWrongQuestionModel.fromDatabase(map))
            .toList();
    return skillWrongQuestionsList;
  }
}
