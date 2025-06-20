class McqOptionsEntity {
  int? id;
  int? questionId;
  String? optionText;
  int? isCorrect;
  McqOptionsEntity({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  });

}