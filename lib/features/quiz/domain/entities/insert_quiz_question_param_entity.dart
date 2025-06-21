class InsertQuizQuestionParamEntity {
  final int? quizId;
  final int? questionId;
  final String? questionLevel;
  final String? userAnswer;
  final int? isCorrect;

  InsertQuizQuestionParamEntity({
    required this.quizId,
    required this.questionId,
    required this.questionLevel,
    required this.userAnswer,
    required this.isCorrect,
  });
}
