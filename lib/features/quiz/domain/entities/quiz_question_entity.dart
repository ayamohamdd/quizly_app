class QuizQuestionEntity {
  int? id;
  int? skillId;
  String? questionText;
  String? level;
  String? type;
  String? correctAnswer;
  String? explanation;
  QuizQuestionEntity({
    required this.id,
    required this.skillId,
    required this.questionText,
    required this.level,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
  });
}
