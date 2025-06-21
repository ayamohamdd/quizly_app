abstract class SkillPerformanceState {}

final class SkillPerformanceInitial extends SkillPerformanceState {}

final class SkillPerformanceCreateQuizLoading extends SkillPerformanceState {}

final class SkillPerformanceCreateQuizSuccess extends SkillPerformanceState {
  final int quizId;

  SkillPerformanceCreateQuizSuccess({required this.quizId});
}

final class SkillPerformanceCreateQuizFailure extends SkillPerformanceState {
  final String error;

  SkillPerformanceCreateQuizFailure({required this.error});
}
