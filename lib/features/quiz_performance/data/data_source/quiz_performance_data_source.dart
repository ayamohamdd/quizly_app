import 'dart:developer';

import 'package:quizly_app/core/sqflite/sqflite_provider.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';

abstract class QuizPerformanceDataSource {
  Future<List<QuizPerformanceModel>> getQuizPerformancePerLevel(int? quizId);
  double getQuizScore(List<QuizPerformanceModel> quizPerformance);
}

class QuizPerformanceDataSourceImpl extends QuizPerformanceDataSource {
  final SqfliteProvider sqfliteProvider;

  QuizPerformanceDataSourceImpl({required this.sqfliteProvider});

  @override
  Future<List<QuizPerformanceModel>> getQuizPerformancePerLevel(
    int? quizId,
  ) async {
    final quizPerformanceData = await sqfliteProvider
        .getQuizPerformancePerLevel(quizId!);
    List<QuizPerformanceModel> quizPerformanceList =
        quizPerformanceData
            .map((map) => QuizPerformanceModel.fromDatabase(map))
            .toList();

    return quizPerformanceList;
  }

  @override
  double getQuizScore(List<QuizPerformanceModel>? quizPerformance) {
    double totalScore = 0;
    int totalQuestions = 0;

    for (var levelScore in quizPerformance!) {
      // for (var levelScore in quizPerformance!) {
  log('Level: ${levelScore.questionLevel}, total: ${levelScore.total}, correct: ${levelScore.correct}');
// }

      totalQuestions += levelScore.total??0;
      totalScore += levelScore.correct??0;
    }
    totalScore /= totalQuestions;

    return totalScore * 100;
  }
}
