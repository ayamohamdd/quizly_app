class FetchQuestionsParamEntity {
  final int skillId;
  final int numberOfQuestions;
  final List<String> levels;

  FetchQuestionsParamEntity({
    required this.skillId,
    required this.numberOfQuestions,
    required this.levels,
  });
}
