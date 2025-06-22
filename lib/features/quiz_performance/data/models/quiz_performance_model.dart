
class QuizPerformanceModel {
  final String? questionLevel;
  final int? total;
  final int? correct;
  final double? percentage;

  QuizPerformanceModel({
    required this.questionLevel,
    required this.total,
    required this.correct,
    required this.percentage,
  });
  factory QuizPerformanceModel.fromDatabase(Map<String, dynamic> db) {
    return QuizPerformanceModel(
      questionLevel: db["question_level"],
      total: db["total"],
      correct: db["correct"],
      percentage: db["percentage"],
    );
  }
}
