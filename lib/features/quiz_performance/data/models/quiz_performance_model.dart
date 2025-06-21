import 'package:quizly_app/features/quiz_performance/domain/entities/quiz_performance_entity.dart';

class QuizPerformanceModel extends QuizPerformanceEntity {
  @override
  final String? questionLevel;
  @override
  final int? total;
  @override
  final int? correct;
  @override
  final double? percentage;

  QuizPerformanceModel({
    required this.questionLevel,
    required this.total,
    required this.correct,
    required this.percentage,
  }) : super(
         questionLevel: questionLevel,
         total: total,
         correct: correct,
         percentage: percentage,
       );
  factory QuizPerformanceModel.fromDatabase(Map<String, dynamic> db) {
    return QuizPerformanceModel(
      questionLevel: db["question_level"],
      total: db["total"],
      correct: db["correct"],
      percentage: db["percentage"],
    );
  }
}
