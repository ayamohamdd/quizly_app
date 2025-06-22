class QuizWrongQuestionModel {
  final int? id;
  final String? questionText;
  final String? userAnswer;
  final String? correctAnswer;

  QuizWrongQuestionModel({
    required this.id,
    required this.questionText,
    required this.userAnswer,
    required this.correctAnswer,
  });

  factory QuizWrongQuestionModel.fromDatabase(Map<String, dynamic> db) {
    return QuizWrongQuestionModel(
      id: db["id"],
      questionText: db["question_text"],
      userAnswer: db["user_answer"],
      correctAnswer: db["correct_answer"],
    );
  }
}
