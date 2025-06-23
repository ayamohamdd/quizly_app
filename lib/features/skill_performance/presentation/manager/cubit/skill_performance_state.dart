import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';

abstract class SkillPerformanceState {}

final class SkillPerformanceInitial extends SkillPerformanceState {}

final class SkillPerformanceStates extends SkillPerformanceState {
  final List<QuizPerformanceModel>? skillPerformanceList;
  final double? score;
  final bool? createLoading;
  final bool? createSuccess;
  final bool? createError;
  final String? createErrorMessage;
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isError;
  final String? errorMessage;
  final List<QuizWrongQuestionModel>? skillWrongQuestionsList;
  final int? quizId;

  SkillPerformanceStates({
    this.skillPerformanceList,
    this.score,
    this.isLoading,
    this.isSuccess,
    this.isError,
    this.errorMessage,
    this.skillWrongQuestionsList,
    this.quizId,
    this.createLoading,
    this.createSuccess,
    this.createError,
    this.createErrorMessage,
  });

  SkillPerformanceStates copyWith({
    List<QuizPerformanceModel>? skillPerformanceList,
    List<QuizWrongQuestionModel>? skillWrongQuestionsList,
    double? score,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    int? quizId,
    bool? createLoading,
    bool? createSuccess,
    bool? createError,
    String? createErrorMessage,
  }) {
    return SkillPerformanceStates(
      skillPerformanceList: skillPerformanceList ?? this.skillPerformanceList,
      score: score ?? this.score,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      skillWrongQuestionsList:
          skillWrongQuestionsList ?? this.skillWrongQuestionsList,
      quizId: quizId ?? quizId,
      createLoading: createLoading ?? this.createLoading,
      createSuccess: createSuccess ?? this.createSuccess,
      createError: createError ?? this.createError,
      createErrorMessage: createErrorMessage ?? this.createErrorMessage,
    );
  }
}

// final class SkillPerformanceCreateQuizLoading extends SkillPerformanceState {}

// final class SkillPerformanceCreateQuizSuccess extends SkillPerformanceState {
//   final int quizId;

//   SkillPerformanceCreateQuizSuccess({required this.quizId});
// }

// final class SkillPerformanceCreateQuizFailure extends SkillPerformanceState {
//   final String error;

//   SkillPerformanceCreateQuizFailure({required this.error});
// }
