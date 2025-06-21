class InsertQuizQuestionParamEntity {
  final int? quizId;
  final int? questionId;
  final String? userAnswer;
  final int? isCorrect;

  InsertQuizQuestionParamEntity({required this.quizId, required this.questionId, required this.userAnswer, required this.isCorrect});
}
