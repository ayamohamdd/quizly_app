import 'package:quizly_app/features/quiz_performance/data/models/quiz_performance_model.dart';
import 'package:quizly_app/features/quiz_performance/data/models/quiz_wrong_question_model.dart';

abstract class QuizPerformanceState {}

final class QuizPerformanceInitial extends QuizPerformanceState {}

final class GetQuizPerformanceState extends QuizPerformanceState {
  final List<QuizPerformanceModel>? quizPerformanceList;
  final double? score;
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isError;
  final String? errorMessage;
  final List<QuizWrongQuestionModel>? quizWrongQuestionsList;

  GetQuizPerformanceState({
    this.isLoading,
    this.isSuccess,
    this.isError,
    this.quizPerformanceList,
    this.score,
    this.errorMessage,
    this.quizWrongQuestionsList,
  });
  GetQuizPerformanceState copyWith({
    List<QuizPerformanceModel>? quizPerformanceList,
    List<QuizWrongQuestionModel>? quizWrongQuestionsList,

    double? score,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
  }) {
    return GetQuizPerformanceState(
      quizPerformanceList: quizPerformanceList ?? this.quizPerformanceList,
      score: score ?? this.score,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      quizWrongQuestionsList:
          quizWrongQuestionsList ?? this.quizWrongQuestionsList,
    );
  }
}
